import SwiftUI

struct TwoColumnView<Element, Content>: View
    where Element: Hashable,
    Content: View {
    let elements: [Element]
    let content: (_ element: Element) -> Content

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(Array(elements.pairs()), id: \.self) { pair in
                    HStack {
                        content(pair.first)

                        if let second = pair.second {
                            content(second)
                        }
                    }
                }
            }
        }
    }
}
