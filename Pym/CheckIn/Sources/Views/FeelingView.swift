import PymCore
import SwiftUI

struct FeelingView: View {
    let next: (_ feeling: Set<Feeling>) -> Void
    @State private var selectedFeelings: Set<Feeling> = []

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

            Button(action: callNext, label: {
                Text("continue")
                    .bold()
                Spacer()
            })
                .buttonStyle(PrimaryButtonStyle())
        }
        .padding(16)
    }

    private func callNext() {
        next(selectedFeelings)
    }

    private func select(_ feeling: Feeling) {
        selectedFeelings.toggle(feeling)
    }
}

struct FeelingView_Previews: PreviewProvider {
    static var previews: some View {
        FeelingView { print($0) }
    }
}
