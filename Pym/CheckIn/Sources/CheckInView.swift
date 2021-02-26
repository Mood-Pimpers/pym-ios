import PymCore
import SwiftUI

public struct CheckInView: View {
    let onClose: (_ entry: MoodEntry) -> Void

    @State var currentPage = CheckInPage.mood

    @State private var mood: MoodRating?
    @State private var feelings: Set<Feeling> = []
    @State private var activities: Set<Activity> = []

    private let dataAccess = DataAccessController.shared
    @State private var allFeelings: [Feeling] = []
    @State private var allActivities: [Activity] = []

    @State private var showFinishAnimation = false
    private var finishAnimationTime: DispatchTime {
        DispatchTime.now() + 0.2
    }

    private func onAppear() {
        allFeelings = Feeling.allCases
        allActivities = dataAccess.getActivities()
    }

    public func checkInSubView<Content>(
        title: String,
        content: Content,
        buttonText: String
    ) -> some View
        where Content: View {
        VStack {
            Title(title)
            content
            Spacer()

            Button(action: next, label: {
                Text(buttonText)
                    .bold()
                Spacer()
                Image(systemName: "arrow.right")
            })
                .buttonStyle(PrimaryButtonStyle())
                .disabled(mood == nil)
        }
        .padding(16)
    }

    public var body: some View {
        VStack {
            if showFinishAnimation {
                VStack {
                    Image.duckFinish
                    Text("Mood Entry Added")
                        .font(.title)
                        .padding(.top, 20)
                }
                .padding(16)
            } else {
                PickerPageView(currentPage: $currentPage) {
                    checkInSubView(
                        title: "How are you feeling?",
                        content: MoodInput(mood: $mood),
                        buttonText: "continue"
                    )
                    .tag(CheckInPage.mood)
                    .disableDrag(when: { mood == nil })

                    checkInSubView(
                        title: "Describe your feelings?",
                        content: FeelingInput(
                            feelings: $feelings,
                            allFeelings: $allFeelings
                        ),
                        buttonText: "continue"
                    )
                    .tag(CheckInPage.feeling)

                    checkInSubView(
                        title: "Why are you feeling this way?",
                        content: ActivityInput(
                            activities: $activities,
                            allActivities: $allActivities
                        ),
                        buttonText: "save"
                    )
                    .tag(CheckInPage.activity)
                }
            }
        }
        .onAppear(perform: onAppear)
    }

    private func next() {
        switch currentPage {
        case .mood:
            if mood != nil {
                currentPage = .feeling
            }
        case .feeling:
            currentPage = .activity
        case .activity:
            showFinishAnimation = true
            DispatchQueue.main.asyncAfter(deadline: finishAnimationTime, execute: finish)
        }
    }

    private func finish() {
        let entry = MoodEntry(
            date: Date(),
            rating: mood ?? MoodRating.good,
            feelings: feelings,
            activities: activities
        )

        dataAccess.store(entry: entry)
        onClose(entry)
    }
}

struct CheckInView_Previews: PreviewProvider {
    static var previews: some View {
        CheckInView { print("close \($0.id)") }
    }
}
