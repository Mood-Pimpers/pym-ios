import PymCore
import SwiftUI

public struct MoodView: View {
    @StateObject var viewRouter: CheckInViewRouter
    @State private var mood: MoodRating?

    public var body: some View {
        VStack {
            Title("How are you feeling?")
            GeometryReader { metrics in
                // TODO: Use ColumnView component instead
                let count = CGFloat(MoodRating.allCases.count)
                let width = metrics.size.width / count
                let spacing = 8 * (count - 1) / count
                HStack {
                    ForEach(MoodRating.allCases, id: \.self) { rating in
                        VStack(spacing: 8) {
                            SelectableElement(
                                isSelected: mood == rating,
                                content: { rating.image },
                                action: { mood = rating },
                                width: width - spacing
                            )
                            Text(rating.description)
                                .font(.caption)
                        }
                    }
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
