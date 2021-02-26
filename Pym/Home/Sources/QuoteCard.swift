import Kingfisher
import PymCore
import SwiftUI

let fade = LinearGradient(
    gradient: Gradient(
        colors: [Color.black.opacity(0), .black]),
    startPoint: .top,
    endPoint: .bottom
)

struct QuoteCard: View {
    let quote: Quote
    let geometry: GeometryProxy
    @State private var show = false

    public var body: some View {
        let width: CGFloat = geometry.size.width * 0.8
        let height: CGFloat = width / 1.5

        ZStack(alignment: .bottom) {
            KFImage(quote.url(Int(width), Int(height)))
                .frame(width: width, height: height)
                .shadow(color: Color.dropShadowColor, radius: 8, x: 0, y: 4)
            fade
                .frame(width: width, height: height)
            HStack(alignment: .top, spacing: 8) {
                Text("\"")
                    .font(.title)
                    .bold()
                VStack(alignment: .leading, spacing: 16) {
                    Text(quote.text)
                    Text("- \(quote.author)")
                }
            }
            .foregroundColor(.white)
            .padding(16)
            .frame(width: width)
        }
        .cornerRadius(8)
        .shadow(color: Color.dropShadowColor, radius: 8)
        .padding(8) // So dropshadow is shown
        .fullScreenCover(isPresented: $show) {
            QuoteModal(quote: quote, geometry: geometry)
        }
        .onTapGesture {
            show.toggle()
        }
    }
}

struct QuoteCard_Previews: PreviewProvider {
    static var previews: some View {
        let quote = Quote(
            id: 1,
            text: "Be yourself; everyone else is already taken.",
            author: "Oscar Wilde",
            url: { width, height in URL(string: "https://images.unsplash.com/photo-1540206395-68808572332f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=\(width)&h=\(height)&q=80")! }
        )

        GeometryReader { geometry in
            QuoteCard(quote: quote, geometry: geometry)
        }
    }
}
