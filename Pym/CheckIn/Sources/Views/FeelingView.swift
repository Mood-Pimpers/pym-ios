import PymCore
import SwiftUI

// TODO: Rename to FeelingInput
struct FeelingView: View {
    @Binding var feelings: Set<Feeling> // TODO: as array
    @Binding var allFeelings: Set<Feeling>

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
            elements: Array(allFeelings),
            columns: 2,
            content: feelingSelectable
        )
    }

    private func select(_ feeling: Feeling) {
        feelings.toggle(feeling)
    }
}

struct FeelingView_Previews: PreviewProvider {
    static var previews: some View {
        FeelingView(
            feelings: Binding<Set<Feeling>>.constant([]),
            allFeelings: Binding<Set<Feeling>>.constant(Set(Feeling.allCases))
        )
    }
}
