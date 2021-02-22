import PymCore
import SwiftUI

struct FeelingView: View {
    @StateObject var viewRouter: CheckInViewRouter
    @State var selectedFeelings: [Feeling] = []

    private func feelingSelectable(_ feeling: Feeling, _ geometry: GeometryProxy) -> some View {
        SelectableElement(
            isSelected: selectedFeelings.contains(feeling),
            content: {
                HStack {
                    feeling.color
                        .frame(width: 12, height: 12)
                        .cornerRadius(8)
                    Text(feeling.description)
                    Spacer()
                }
                .padding(8)
            },
            action: { select(feeling) },
            width: geometry.size.width / 2 - 16 - 4
        )
    }

    public var body: some View {
        GeometryReader { geometry in
            VStack {
                Title("Describe your feelings?")
                TwoColumnView(elements: Feeling.allCases) { feeling in
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

    private func select(_ feeling: Feeling) {
        if !selectedFeelings.contains(feeling) {
            selectedFeelings.append(feeling)
        }
    }
}

struct FeelingView_Previews: PreviewProvider {
    static var previews: some View {
        FeelingView(viewRouter: CheckInViewRouter())
    }
}
