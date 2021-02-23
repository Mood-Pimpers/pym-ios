import PymCore
import SwiftUI

struct MoodView: View {
    let next: (_ rating: MoodRating) -> Void
    @State private var mood: MoodRating?

    var body: some View {
        VStack {
            Title("How are you feeling?")
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

            Spacer()

            Button(action: callNext, label: {
                Text("continue")
                    .bold()
                Spacer()
                Image(systemName: "arrow.right")
            })
                .buttonStyle(PrimaryButtonStyle())
                .disabled(mood == nil)
        }
        .padding(16)
    }

    private func callNext() {
        if let mood = mood {
            next(mood)
        }
    }
}

struct MoodView_Previews: PreviewProvider {
    static var previews: some View {
        MoodView { print($0) }
    }
}
