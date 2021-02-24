import PymCore
import SwiftUI

public struct CheckInView: View {
    let onClose: (_ entry: MoodEntry) -> Void

    @StateObject private var viewRouter = CheckInViewRouter()

    @State private var mood: MoodRating?
    @State private var feelings: Set<Feeling> = []
    @State private var activities: Set<Activity> = []

    private let dataAccess = DataAccessController.shared
    @State private var allFeelings: [Feeling] = []
    @State private var allActivities: [Activity] = []

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
            if viewRouter.currentPage != .finish {
                // TODO: Use Simons component when in main
                HStack(spacing: 8) {
                    (viewRouter.currentPage == .mood ? Color.primaryColor : Color.neutralLightColor)
                        .cornerRadius(4)

                    (viewRouter.currentPage == .feeling ? Color.primaryColor : Color.neutralLightColor)
                        .cornerRadius(4)

                    (viewRouter.currentPage == .activity ? Color.primaryColor : Color.neutralLightColor)
                        .cornerRadius(4)
                }
                .frame(maxWidth: .infinity, maxHeight: 8.0)
                .padding(8)
            }

            Spacer()
            switch viewRouter.currentPage {
            case .mood:
                checkInSubView(
                    title: "How are you feeling?",
                    content: MoodInput(mood: $mood),
                    buttonText: "continue"
                )
            case .feeling:
                checkInSubView(
                    title: "Describe your feelings?",
                    content: FeelingInput(
                        feelings: $feelings,
                        allFeelings: $allFeelings
                    ),
                    buttonText: "continue"
                )
            case .activity:
                checkInSubView(
                    title: "Why are you feeling this way?",
                    content: ActivityInput(
                        activities: $activities,
                        allActivities: $allActivities
                    ),
                    buttonText: "save"
                )
            case .finish:
                VStack {
                    Image.duckFinish
                    Text("Mood Entry Added")
                        .font(.title)
                        .padding(.top, 20)
                }
                .padding(16)
            }
            Spacer()
        }
        .onAppear(perform: onAppear)
        .onSwipe(
            left: next,
            right: previous
        )
    }

    private func previous() {
        switch viewRouter.currentPage {
        case .mood, .feeling: viewRouter.currentPage = .mood
        case .activity: viewRouter.currentPage = .feeling
        case .finish: viewRouter.currentPage = .finish
        }
    }

    private func next() {
        switch viewRouter.currentPage {
        case .mood:
            if mood != nil {
                viewRouter.currentPage = .feeling
            }
        case .feeling:
            viewRouter.currentPage = .activity
        case .activity:
            viewRouter.currentPage = .finish
            DispatchQueue.main.asyncAfter(deadline: finishAnimationTime, execute: finish)
        case .finish:
            print("Something went wrong.")
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
