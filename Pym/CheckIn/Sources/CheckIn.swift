import PymCore
import SwiftUI

// TODO: Use Dto instead!
public struct MoodEntry {
    let mood: Int
    let feelings: [String]
    let activities: [String]
}

public struct CheckInView: View {
    @StateObject var viewRouter = CheckInViewRouter()

    public init() {}

    public var body: some View {
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
            case .mood: MoodView(viewRouter: viewRouter)
            case .feeling: FeelingView(viewRouter: viewRouter)
            case .activity: ActivityView()
            }
            Spacer()
        }
    }
}

struct CheckInView_Previews: PreviewProvider {
    static var previews: some View {
        CheckInView()
    }
}
