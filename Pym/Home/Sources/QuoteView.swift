import PymCore
import SwiftUI

public struct QuoteView: View {
    let quotes: [Quote]
    let metrics: GeometryProxy

    public var body: some View {
        VStack {
            Title("good morning.")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(quotes, id: \.id) { quote in
                        QuoteCard(quote, metrics)
                    }
                }
            }
        }
        .padding(8)
    }
}
