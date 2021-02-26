import CheckIn
import PymCore
import SwiftUI

public struct HomeView: View {
    let dataAcces = DataAccessController.shared
    @ObservedObject private var modalService = ModalService.shared
    @State private var quotes: [Quote] = []

    public init() {}

    private func load() {
        quotes = dataAcces.getQuotes()
    }

    public var body: some View {
        GeometryReader { metrics in
            ScrollView(.vertical) {
                VStack {
                    VStack(spacing: 0) {
                        Title("good day.")
                            .padding([.leading, .trailing], 16)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                ForEach(quotes, id: \.id) { quote in
                                    QuoteCard(quote: quote, geometry: metrics)
                                }
                            }
                            .padding([.leading, .trailing], 8)
                        }
                    }
                    .padding([.top, .bottom], 16)

                    VStack {
                        Title("track your mood")
                        Button(action: modalService.toggleMoodCheckin, label: {
                            Text("mood checkin")
                            Spacer()
                            Image(systemName: "arrow.right")
                        })
                            .buttonStyle(PrimaryButtonStyle())
                    }
                    .padding(16)

                    Spacer()
                }
            }
        }
        .onAppear(perform: load)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
