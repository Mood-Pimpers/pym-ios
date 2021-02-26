import Kingfisher
import PymCore
import SwiftUI

struct QuoteModal: View {
    @Environment(\.presentationMode) var presentationMode

    let quote: Quote
    let geometry: GeometryProxy

    var body: some View {
        let width = geometry.size.width
            + geometry.safeAreaInsets.leading
            + geometry.safeAreaInsets.trailing
        let height = geometry.size.height
            + geometry.safeAreaInsets.bottom
            + geometry.safeAreaInsets.top

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
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
