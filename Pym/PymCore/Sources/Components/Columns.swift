import SwiftUI

public struct Columns<Element, Content>: View where Element: Hashable, Content: View {
    // TODO: Use Sequence instead of an Array...
    let elements: [Element]
    let columns: Int
    let spacing: CGFloat
    let content: (_ element: Element, _ width: CGFloat) -> Content

    public init(elements: [Element], columns: Int, spacing: CGFloat, @ViewBuilder content: @escaping (_ element: Element, _ width: CGFloat) -> Content) {
        self.elements = elements
        self.columns = columns
        self.spacing = spacing
        self.content = content
    }

    public init(elements: [Element], @ViewBuilder content: @escaping (_ element: Element, _ width: CGFloat) -> Content) {
        self.init(
            elements: elements,
            columns: elements.count,
            spacing: 8,
            content: content
        )
    }

    public init(elements: [Element], columns: Int, @ViewBuilder content: @escaping (_ element: Element, _ width: CGFloat) -> Content) {
        self.init(
            elements: elements,
            columns: columns,
            spacing: 8,
            content: content
        )
    }

    private func width(_ geometry: GeometryProxy) -> CGFloat {
        let count = CGFloat(columns)
        let spacingBetween = spacing * (count - 1) / count
        return CGFloat(geometry.size.width / count - spacingBetween)
    }

    public var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(elements.chunked(into: columns), id: \.self) { chunk in
                        HStack(spacing: spacing) {
                            ForEach(chunk, id: \.self) { element in
                                content(element, width(geometry))
                            }
                        }
                    }
                }
            }
        }
    }
}
