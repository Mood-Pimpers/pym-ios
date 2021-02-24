import PymCore
import SwiftUI

public struct CheckInView: View {
    let onClose: (_ entry: MoodEntry) -> Void

    @StateObject var viewRouter = CheckInViewRouter()

    @State private var mood = MoodRating.moderate
    @State private var feelings: Set<Feeling> = []

    // TODO: typealias Activity = String ???
    @State private var activities: Set<String> = []

    private let dataAccess = DataAccessController.shared
    private let allActivities: Set<String>

    public init(onClose: @escaping (_ entry: MoodEntry) -> Void) {
        self.onClose = onClose
        allActivities = dataAccess.getActivities()
    }

    public var body: some View {
        // TODO: Use Simons component when in main

        VStack {
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

            Spacer()
            switch viewRouter.currentPage {
            case .mood:
                MoodView { selectedMood in
                    viewRouter.currentPage = .feeling
                    self.mood = selectedMood
                }
            case .feeling:
                FeelingView { selectedFeelings in
                    viewRouter.currentPage = .activity
                    self.feelings = selectedFeelings
                }
            case .activity:
                ActivityView(activities: allActivities) { selectedActivities in
                    self.activities = selectedActivities
                    finish()
                }
            }
            Spacer()
        }
    }

    private func finish() {
        let entry = MoodEntry(
            date: Date(),
            rating: mood,
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
