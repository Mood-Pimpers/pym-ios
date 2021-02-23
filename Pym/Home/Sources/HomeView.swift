import CheckIn
import PymCore
import SwiftUI

public struct HomeView: View {
    // TODO: Load quotes from a service
    @State private var quotes = [
        Quote(
            id: 1,
            text: "Be yourself; everyone else is already taken.",
            author: "Oscar Wilde",
            url: { width, height in URL(string: "https://images.unsplash.com/photo-1540206395-68808572332f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=\(width)&h=\(height)&q=80")! }
        ),
        Quote(
            id: 2,
            text: "Life is what happens when you’re busy making other plans.",
            author: "John Lennon",
            url: { width, height in URL(string: "https://images.unsplash.com/photo-1446329813274-7c9036bd9a1f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=\(width)&h=\(height)&q=80")! }
        ),
        Quote(
            id: 3,
            text: "This is a really long quote, that doesn't make any sense but I just wanted to test it!",
            author: "Daniel Bauer",
            url: { width, height in URL(string: "https://images.unsplash.com/photo-1470770903676-69b98201ea1c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=\(width)&h=\(height)&q=80")! }
        ),
        Quote(
            id: 4,
            text: "White photo to see that fade ;)",
            author: "Daniel Bauer",
            url: { width, height in URL(string: "https://images.unsplash.com/photo-1543751737-d7cf492060cd?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=\(width)&h=\(height)&q=80")! }
        )
    ]
    @State private var showMoodCheckin = false

    public init() {}

    public var body: some View {
        GeometryReader { metrics in
            ScrollView(.vertical) {
                VStack {
                    VStack(spacing: 0) {
                        Title("good morning.")
                            .padding([.leading, .trailing], 16)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                ForEach(quotes, id: \.id) { quote in
                                    QuoteCard(quote: quote, metrics: metrics)
                                }
                            }
                            .padding([.leading, .trailing], 8)
                        }
                    }
                    .padding([.top, .bottom], 16)

                    VStack {
                        Title("track your mood")
                        Button(action: toggleMoodCheckin, label: {
                            Text("mood checkin")
                            Spacer()
                            Image(systemName: "arrow.right")
                        })
                            .buttonStyle(PrimaryButtonStyle())
                            .sheet(isPresented: $showMoodCheckin, content: CheckInModalView.init)
                    }
                    .padding(16)

                    Spacer()
                }
            }
        }
    }

    private func toggleMoodCheckin() {
        showMoodCheckin.toggle()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
