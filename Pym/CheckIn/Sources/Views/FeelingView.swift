import PymCore
import SwiftUI

struct FeelingView: View {
    @StateObject var viewRouter: CheckInViewRouter
    @State var selectedFeelings: Set<Feeling> = []

    private func feelingSelectable(_ feeling: Feeling, _ width: CGFloat) -> some View {
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
            width: width
        )
    }

    public var body: some View {
        VStack {
            Title("Describe your feelings?")
            Columns(
                elements: Feeling.allCases,
                columns: 2,
                content: feelingSelectable
            )

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

    private func next() {
        viewRouter.currentPage = .activity
    }

    private func select(_ feeling: Feeling) {
        selectedFeelings.toggle(feeling)
    }
}

struct FeelingView_Previews: PreviewProvider {
    static var previews: some View {
        FeelingView(viewRouter: CheckInViewRouter())
    }
}
