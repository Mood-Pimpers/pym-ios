import PymCore
import SwiftUI

// TODO: don't know why this is not found?!
public struct PrimaryButton<Content>: View where Content: View {
    let content: () -> Content
    let action: () -> Void

    public init(action: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.action = action
    }

    public var body: some View {
        Button(action: self.action) {
            HStack(alignment: .center) {
                content()
            }
        }
        .padding(16)
        .background(Color.primaryColor)
        .foregroundColor(.black)
        .cornerRadius(8.0)
        .shadow(color: Color.dropShadowColor, radius: 8, x: 0, y: 4)
    }
}

public struct MoodView: View {
    @StateObject var viewRouter: ViewRouter

    public var body: some View {
        VStack {
            Spacer()

            PrimaryButton(action: next) {
                Text("continue")
                    .bold()
                Spacer()
            }
            .padding(16)
        }
    }

    private func next() {
        viewRouter.currentPage = .feeling
    }
}

struct FeelingView: View {
    public var body: some View {
        Text("Feeling")
    }
}

struct ActivityView: View {
    public var body: some View {
        Text("Activity")
    }
}

enum Test {
    case mood
    case feeling
    case activity
}

class ViewRouter: ObservableObject {
    @Published var currentPage: Test = .mood
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
            case .feeling: FeelingView()
            case .activity: ActivityView()
            }
            Spacer()
        }
    }
}

#if DEBUG
    struct CheckInView_Previews: PreviewProvider {
        static var previews: some View {
            CheckInView()
        }
    }
#endif
