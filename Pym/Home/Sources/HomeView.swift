import Kingfisher
import PymCore
import SwiftUI

public struct Title: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }

    public var body: some View {
        HStack {
            Text(text)
                .bold()
                .font(.title)
            Spacer()
        }
        .padding(EdgeInsets(top: 16 + 8, leading: 16, bottom: 8, trailing: 16))
    }
}

public struct Quote {
    let id: Int
    let text: String
    let author: String
    let url: (_ width: Int) -> URL
}

let fade = LinearGradient(gradient: Gradient(
    colors: [Color.black.opacity(0), .black]),
startPoint: .top,
endPoint: .bottom)

public struct QuoteCard: View {
    let quote: Quote
    let metrics: GeometryProxy

    init(_ quote: Quote, _ metrics: GeometryProxy) {
        self.quote = quote
        self.metrics = metrics
    }

    public var body: some View {
        let width: CGFloat = metrics.size.width * 0.8
        let height: CGFloat = width / 1.5

        ZStack(alignment: .bottom) {
            KFImage(quote.url(Int(width)))
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
    }
}

public struct HomeView: View {
    private let quotes = [
        Quote(
            id: 1,
            text: "Be yourself; everyone else is already taken.",
            author: "Oscar Wilde",
            url: { width in URL(string: "https://images.unsplash.com/photo-1540206395-68808572332f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=\(width)&q=80")! }
        ),
        Quote(
            id: 2,
            text: "Life is what happens when you’re busy making other plans.",
            author: "John Lennon",
            url: { width in URL(string: "https://images.unsplash.com/photo-1446329813274-7c9036bd9a1f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=\(width)&q=80")! }
        ),
        Quote(
            id: 3,
            text: "This is a really long quote, that doesn't make any sense but I just wanted to test it!",
            author: "Daniel Bauer",
            url: { width in URL(string: "https://images.unsplash.com/photo-1470770903676-69b98201ea1c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=\(width)&q=80")! }
        ),
        Quote(
            id: 4,
            text: "White photo to see that fade ;)",
            author: "Daniel Bauer",
            url: { width in URL(string: "https://images.unsplash.com/photo-1543751737-d7cf492060cd?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=\(width)&q=80")! }
        )
    ]

    public init() {}

    public var body: some View {
        GeometryReader { metrics in
            VStack {
                Title("good morning.")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(quotes, id: \.id) { quote in
                            QuoteCard(quote, metrics)
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                }
                Title("track your mood")
                Button(action: {}, label: {
                    HStack(alignment: .center) {
                        Text("mood checkin")
                            .bold()
                    }
                })
                    .padding(16)
                    .background(Color.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(8.0)
                    .shadow(color: Color.dropShadowColor, radius: 8, x: 0, y: 4)
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
