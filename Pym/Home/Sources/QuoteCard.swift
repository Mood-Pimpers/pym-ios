//
//  QuoteCard.swift
//  Home
//
//  Created by Daniel Bauer on 21.12.20.
//

import Kingfisher
import SwiftUI

let fade = LinearGradient(gradient: Gradient(
    colors: [Color.black.opacity(0), .black]),
startPoint: .top,
endPoint: .bottom)

public struct QuoteCard: View {
    let quote: Quote
    let metrics: GeometryProxy
    @State private var show: Bool = false

    init(_ quote: Quote, _ metrics: GeometryProxy) {
        self.quote = quote
        self.metrics = metrics
    }

    public var body: some View {
        let width: CGFloat = metrics.size.width * 0.8
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
        .fullScreenCover(isPresented: $show, content: { QuoteModalView(quote, metrics) })
        .onTapGesture {
            show.toggle()
        }
    }
}

struct QuoteModalView: View {
    @Environment(\.presentationMode) var presentationMode

    let quote: Quote
    let metrics: GeometryProxy

    init(_ quote: Quote, _ metrics: GeometryProxy) {
        self.quote = quote
        self.metrics = metrics
    }

    var body: some View {
        let width = metrics.size.width +
            metrics.safeAreaInsets.leading +
            metrics.safeAreaInsets.trailing
        let height = metrics.size.height + metrics.safeAreaInsets.bottom + metrics.safeAreaInsets.top

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

        // KFImage(quote.url(Int(width), Int(height)))
        // .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(maxWidth: width, maxHeight: height)
        .background(Color.red)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
