import PymCore
import SwiftUI

struct Feeling: Hashable {
    let color: Color
    let name: String
}

struct FeelingView: View {
    @StateObject var viewRouter: CheckInViewRouter
    @State var selectedFeelings: [String] = []

    private let feelings = [
        Feeling(color: Color.red, name: "angry"),
        Feeling(color: Color.red, name: "upset"),
        Feeling(color: Color.red, name: "irritated"),
        Feeling(color: Color.orange, name: "clear"),
        Feeling(color: Color.orange, name: "curious"),
        Feeling(color: Color.orange, name: "enthusiastic"),
        Feeling(color: Color.yellow, name: "happy"),
        Feeling(color: Color.yellow, name: "relaxed")
    ]

    private func feelingSelectable(_ feeling: Feeling, _ geometry: GeometryProxy) -> some View {
        SelectableElement(
            isSelected: selectedFeelings.contains(feeling.name),
            content: {
                HStack {
                    feeling.color
                        .frame(width: 12, height: 12)
                        .cornerRadius(8)
                    Text(feeling.name)
                    Spacer()
                }
                .padding(8)
            },
            action: {
                if !selectedFeelings.contains(feeling.name) {
                    selectedFeelings.append(feeling.name)
                }
            },
            width: geometry.size.width / 2 - 16 - 4
        )
    }

    public var body: some View {
        GeometryReader { geometry in
            VStack {
                Title("Describe your feelings?")
                TwoColumnView(elements: feelings) { feeling in
                    feelingSelectable(feeling, geometry)
                }

                Spacer()

                Button(action: next, label: {
                    Text("continue")
                        .bold()
                    Spacer()
                })
                    .buttonStyle(PrimaryButtonStyle())
            }
            .padding(16)
        }
    }

    private func next() {
        viewRouter.currentPage = .activity
    }

    private func select(feeling: Feeling) {
        if !selectedFeelings.contains(feeling.name) {
            selectedFeelings.append(feeling.name)
        }
    }
}

struct FeelingView_Previews: PreviewProvider {
    static var previews: some View {
        FeelingView(viewRouter: CheckInViewRouter())
    }
}
