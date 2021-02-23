import PymCore
import SwiftUI

public struct MoodView: View {
    @StateObject var viewRouter: CheckInViewRouter
    @State private var mood: MoodRating?

    public var body: some View {
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

            Button(action: next, label: {
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

    private func next() {
        viewRouter.currentPage = .feeling
    }
}

struct MoodView_Previews: PreviewProvider {
    static var previews: some View {
        MoodView(viewRouter: CheckInViewRouter())
    }
}
