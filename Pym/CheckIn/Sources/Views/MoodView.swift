import PymCore
import SwiftUI

// TODO: Rename to mood input
struct MoodView: View {
    @Binding var mood: MoodRating?

    var body: some View {
        Columns(elements: MoodRating.allCases) { rating, width in
            VStack(spacing: 8) {
                SelectableElement(
                    isSelected: mood == rating,
                    content: { rating.image },
                    action: { mood = rating },
                    width: width
                )
                Text(rating.description)
                    .font(.caption)
            }
        }
    }
}

struct MoodView_Previews: PreviewProvider {
    static var previews: some View {
        MoodView(mood: Binding<MoodRating?>.constant(MoodRating.good))
    }
}
