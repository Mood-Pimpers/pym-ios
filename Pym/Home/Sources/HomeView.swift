import Kingfisher
import PymCore
import SwiftUI

public struct Title: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }

    public var body: some View {
        Text(text)
            .bold()
            .font(.title)
    }
}

public struct Quote {
    let id: Int
    let text: String
    let author: String
    let url: URL
}

public struct QuoteCard: View {
    let quote: Quote

    init(_ quote: Quote) {
        self.quote = quote
    }

    public var body: some View {
        ZStack(alignment: .bottom) {
            KFImage(quote.url)
                .frame(width: 300, height: 200)
                .cornerRadius(8)
                .shadow(color: Color.dropShadowColor, radius: 8, x: 0, y: 4)
            HStack(alignment: .top, spacing: 8) {
                Text("\"")
                    .font(.title)
                    .bold()
                VStack(alignment: .leading, spacing: 16) {
                    Text(quote.text)
                    Text(quote.author)
                }
            }
            .padding(16)
            .frame(width: 300)
        }
        .padding(8) // So dropshadow is shown
    }
}

public struct HomeView: View {
    private let quotes = [
        Quote(
            id: 1,
            text: "Be yourself; everyone else is already taken.",
            author: "Oscar Wilde",
            url: URL(string: "https://images.unsplash.com/photo-1540206395-68808572332f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=300&q=80")!
        ),
        Quote(
            id: 2,
            text: "Life is what happens when you’re busy making other plans.",
            author: "John Lennon",
            url: URL(string: "https://images.unsplash.com/photo-1446329813274-7c9036bd9a1f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=300&q=80")!
        ),
        Quote(
            id: 3,
            text: "This is a really long quote, that doesn't make any sense but I just wanted to test it!",
            author: "Daniel Bauer",
            url: URL(string: "https://images.unsplash.com/photo-1470770903676-69b98201ea1c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=300&q=80")!
        )
    ]

    public init() {}

    public var body: some View {
        VStack {
            HStack {
                Title("good morning")
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(quotes, id: \.id) { quote in
                        QuoteCard(quote)
                    }
                }
            }
            HStack {
                Title("track your mood")
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            Button(action: {}, label: {
                Text("mood checkin")
            })
            Spacer()
        }
        .padding(20)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
