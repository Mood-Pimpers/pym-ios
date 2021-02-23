import SwiftUI

 // TODO: Add column view
struct TwoColumnView<Element, Content>: View
    where Element: Hashable,
    Content: View {
    let elements: [Element]
    let content: (_ element: Element, _ width: CGFloat) -> Content

    private func width(_ geometry: GeometryProxy) -> CGFloat {
        let count = CGFloat(2)
        let spacing = CGFloat(8 * count - 1) / CGFloat(count)
        return CGFloat(geometry.size.width / count - spacing)
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(Array(elements.pairs()), id: \.self) { pair in
                        HStack {
                            content(pair.first, width(geometry))

                            if let second = pair.second {
                                content(second, width(geometry))
                            }
                        }
                    }
                }
            }
        }
    }
}
