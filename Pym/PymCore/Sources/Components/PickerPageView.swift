import SwiftUI

public struct PickerPageView<Content>: View where Content: View {
    @State public var currentIndex = 0
    var pages: Int
    var spacing: CGFloat
    var content: () -> Content

    public init(spacing: CGFloat? = 8.0, pages: Int = 0, @ViewBuilder content: @escaping () -> Content) {
        self.pages = pages
        self.spacing = spacing ?? 0.8
        self.content = content
    }

    public var body: some View {
        VStack {
            HStack(spacing: spacing) {
                ForEach(0 ..< pages, id: \.self) { pageIndex in
                    (pageIndex == currentIndex ? Color.primaryColor : Color.neutralLightColor)
                        .cornerRadius(4)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 8.0)
            .padding(8)

            Spacer()
            TabView(selection: $currentIndex) {
                content()
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(maxHeight: .infinity)
        }
    }
}

struct PickerPageView_Previews: PreviewProvider {
    static var previews: some View {
        PickerPageView(pages: 3, content: {
            Text("One")
            Text("Two")
            Text("Three")
        })
    }
}
