import PymCore
import SwiftUI

struct FeelingInput: View {
    @Binding var feelings: Set<Feeling>
    @Binding var allFeelings: [Feeling]

    private func feelingSelectable(_ feeling: Feeling, _ width: CGFloat) -> some View {
        SelectableElement(
            isSelected: feelings.contains(feeling),
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
        Columns(
            elements: allFeelings,
            columns: 2,
            content: feelingSelectable
        )
    }

    private func select(_ feeling: Feeling) {
        feelings.toggle(feeling)
    }
}

struct FeelingInput_Previews: PreviewProvider {
    static var previews: some View {
        FeelingInput(
            feelings: Binding.constant([]),
            allFeelings: Binding.constant(Feeling.allCases)
        )
    }
}
