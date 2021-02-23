import Kingfisher
import SwiftUI

struct QuoteModalView: View {
    @Environment(\.presentationMode) var presentationMode

    let quote: Quote
    let metrics: GeometryProxy

    var body: some View {
        let width = metrics.size.width
            + metrics.safeAreaInsets.leading
            + metrics.safeAreaInsets.trailing
        let height = metrics.size.height
            + metrics.safeAreaInsets.bottom
            + metrics.safeAreaInsets.top

        ZStack(alignment: .center) {
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
                        .font(.title)
                    Text("- \(quote.author)")
                        .font(.title2)
                }
            }
            .foregroundColor(.white)
            .padding(16)
            .frame(width: width)
        }

        .frame(maxWidth: width, maxHeight: height)
        .background(Color.red)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
