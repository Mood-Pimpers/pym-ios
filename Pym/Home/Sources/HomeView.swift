import CheckIn
import PymCore
import SwiftUI

struct FullScreenModalView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            CheckInView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColor)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            // presentationMode.wrappedValue.dismiss()
        }
    }
}

public struct HomeView: View {
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

    public init() {}

    @State private var showMoodCheckin = false

    public var body: some View {
        GeometryReader { metrics in
            ScrollView(.vertical) {
                VStack {
                    QuoteView(quotes: quotes, metrics: metrics)
                    Title("track your mood")
                    PrimaryButton(label: "mood checkin", action: toggleMoodCheckin)
                        .sheet(isPresented: $showMoodCheckin, content: FullScreenModalView.init)
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
