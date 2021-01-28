import PymCore
import SwiftUI

public struct MoodEntry {
    let mood: Int
    let feelings: [String]
    let activities: [String]
}

struct SelectableElement<TContent>: View where TContent: View {
    let isSelected: Bool
    let content: TContent
    let action: () -> Void

    var body: some View {
        content
            .frame(width: 64, height: 64)
            .background(isSelected ? Color.primaryColor : Color.white)
            .cornerRadius(4)
            .shadow(color: .neutralLightColor, radius: 8)
            .onTapGesture(perform: action)
    }
}

public struct MoodView: View {
    @StateObject var viewRouter: ViewRouter
    @State private var mood: Int?

    public var body: some View {
        VStack {
            HStack {
                ForEach(1 ..< 6) { index in
                    SelectableElement(
                        isSelected: mood == index,
                        content: Text("\(index)"),
                        action: { mood = index }
                    )
                }
            }

            Spacer()

            PrimaryButton(action: next) {
                Text("continue")
                    .bold()
                Spacer()
            }
            .disabled(mood == nil)
            .padding(16)
        }
    }

    private func next() {
        viewRouter.currentPage = .feeling
    }
}

struct FeelingView: View {
    @StateObject var viewRouter: ViewRouter

    public var body: some View {
        VStack {
            Text("FEELING")
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
        viewRouter.currentPage = .activity
    }
}

struct ActivityView: View {
    @Environment(\.presentationMode) var presentationMode

    public var body: some View {
        VStack {
            Text("ACTIVITY")
            Spacer()

            PrimaryButton(action: finish) {
                Text("finish")
                    .bold()
                Spacer()
            }
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
