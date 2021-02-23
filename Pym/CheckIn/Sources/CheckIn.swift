import PymCore
import SwiftUI

public struct CheckInView: View {
    let onClose: (_ entry: MoodEntry) -> Void

    @StateObject var viewRouter = CheckInViewRouter()

    @State private var mood = MoodRating.moderate
    @State private var feelings: [Feeling] = []
    @State private var activities: [String] = []

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
                MoodView { rating in
                    viewRouter.currentPage = .feeling
                    self.mood = rating
                }
            case .feeling:
                FeelingView { feelings in
                    viewRouter.currentPage = .activity
                    self.feelings = feelings
                }
            case .activity:
                ActivityView { activities in
                    self.activities = activities
                    let entry = MoodEntry(date: Date(), rating: mood, feelings: feelings, activities: activities)
                    onClose(entry)
                }
            }
            Spacer()
        }
    }
}

struct CheckInView_Previews: PreviewProvider {
    static var previews: some View {
        CheckInView { print("close \($0.id)") }
    }
}
