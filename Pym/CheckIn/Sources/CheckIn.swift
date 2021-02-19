import PymCore
import SwiftUI

public struct MoodEntry {
    let mood: Int
    let feelings: [String]
    let activities: [String]
}

public struct MoodView: View {
    @StateObject var viewRouter: ViewRouter
    @State private var mood: Int?

    public var body: some View {
        VStack {
            Title("How are you feeling?")
            HStack {
                ForEach(1 ..< 6) { index in
                    SelectableElement(
                        isSelected: mood == index,
                        content: { Text("\(index)") },
                        action: { mood = index }
                    )
                }
            }

            Spacer()

            Button(action: next, label: {
                Text("continue")
                    .bold()
                Spacer()
                Image(systemName: "arrow.right")
            })
                .buttonStyle(PrimaryButtonStyle())
                .disabled(mood == nil)
                .padding(16)
        }
        .padding(16)
    }

    private func next() {
        viewRouter.currentPage = .feeling
    }
}

struct ActivityView: View {
    @Environment(\.presentationMode) var presentationMode

    public var body: some View {
        VStack {
            Title("Why are you feeling this way?")
            Spacer()

            Button(action: finish, label: {
                Text("finish")
                    .bold()
                Spacer()
            })
                .buttonStyle(PrimaryButtonStyle())
                .padding(16)
        }
    }

    private func finish() {
        presentationMode.wrappedValue.dismiss()
    }
}

enum CheckInPage {
    case mood
    case feeling
    case activity
}

class ViewRouter: ObservableObject {
    @Published var currentPage: CheckInPage = .mood
}

public struct CheckInView: View {
    // @State private var current: Test = .mood
    @StateObject var viewRouter = ViewRouter()

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
