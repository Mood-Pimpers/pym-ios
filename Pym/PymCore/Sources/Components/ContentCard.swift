import SwiftUI

public struct ContentCard<Content: View>: View {
    let height: CGFloat = 81

    var content: (ContentCardAlignmentGuide) -> Content

    public init(@ViewBuilder content: @escaping (ContentCardAlignmentGuide) -> Content) {
        self.content = content
    }

    public var body: some View {
        ZStack {
            Rectangle()
                .frame(height: height)
                .foregroundColor(.white)
                .cornerRadius(20, corners: .allCorners)

            ZStack {
                content(ContentCardAlignmentGuide())
            }
            .padding(.vertical, 2.5)
            .padding(.horizontal, 5)
            .frame(maxHeight: height)
        }
        .frame(maxHeight: height)
    }
}

// MARK: - Visual Extensions

public extension ContentCard {
    func neomorph() -> some View {
        // https://www.hackingwithswift.com/articles/213/how-to-build-neumorphic-designs-with-swiftui
        shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
    }
}

// MARK: - Layout Extensionss

public struct ContentCardAlignmentGuide {
    func top<Content: View>(_ horizontalAlignment: HorizontalAlignment = .center, _ contentBuilder: @escaping () -> Content) -> some View {
        GeometryReader { geometry in
            VStack {
                contentBuilder()
                Spacer()
            }
            .frame(width: geometry.size.width, alignment: Alignment(horizontal: horizontalAlignment, vertical: .center))
        }
    }

    func center<Content: View>(_ horizontalAlignment: HorizontalAlignment = .center, _ contentBuilder: @escaping () -> Content) -> some View {
        GeometryReader { geometry in
            contentBuilder()
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: Alignment(horizontal: horizontalAlignment, vertical: .center))
        }
    }

    func bottom<Content: View>(_ horizontalAlignment: HorizontalAlignment = .center, _ contentBuilder: @escaping () -> Content) -> some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                contentBuilder()
            }.frame(width: geometry.size.width, alignment: Alignment(horizontal: horizontalAlignment, vertical: .center))
        }
    }
}

// MARK: - Preview

struct ContentCard_Previews: PreviewProvider {
    static let neuBackground = Color(red: 240, green: 240, blue: 243)
    static let dropShadow = Color(red: 174, green: 174, blue: 192, opacity: 0.4)
    static let dropLight = Color(red: 255, green: 255, blue: 255)

    static var previews: some View {
        GeometryReader { geometry in
            VStack(spacing: 15) {
                ContentCard { _ in
                    VStack {
                        Text("the content is hereeee")
                        Text("another text")
                    }
                }

                ContentCard { _ in
                    Text("Neomorph version of the content card is here with an text overflow, oh no what's happening, I don't want to go into the dark, noooooooooooo oooooo ooooooo ooooo 😢")
                }
                .neomorph()
                .padding(15)
                .background(Color.gray)

                ContentCard { alignment in
                    alignment.top(.leading) {
                        Text("top leading")
                    }

                    alignment.top {
                        Text("top center")
                    }

                    Text("centered text")

                    alignment.bottom(.center) {
                        Text("The text is at the bottom")
                    }
                }

                ContentCard { alignment in
                    alignment.top(.leading) {
                        Text("top l")
                    }
                    alignment.top(.center) {
                        Text("top c")
                    }
                    alignment.top(.trailing) {
                        Text("top t")
                    }

                    alignment.center(.leading) {
                        Text("center l")
                    }
                    alignment.center(.center) {
                        Text("center c")
                    }
                    alignment.center(.trailing) {
                        Text("center t")
                    }

                    alignment.bottom(.leading) {
                        Text("center l")
                    }
                    alignment.bottom(.center) {
                        Text("center c")
                    }
                    alignment.bottom(.trailing) {
                        Text("center t")
                    }
                }

                ContentCard { alignment in
                    alignment.top(.leading) {
                        Text("Running")
                            .font(.system(size: 20, weight: Font.Weight.bold))
                            .padding([.top, .leading], 10)
                    }

                    alignment.bottom(.leading) {
                        HStack(spacing: 15) {
                            Text("5.3km")
                                .font(.system(size: 15, weight: Font.Weight.light))
                            Text("34min")
                                .font(.system(size: 15, weight: Font.Weight.light))
                            Text("6.31 min/km")
                                .font(.system(size: 15, weight: Font.Weight.light))
                        }
                        .padding([.bottom, .leading], 10)
                    }

                    alignment.top(.trailing) {
                        Text("6:47 am")
                            .font(.system(size: 15, weight: Font.Weight.light))
                            .padding([.top, .trailing], 10)
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.backgroundColor)
        }
    }
}
