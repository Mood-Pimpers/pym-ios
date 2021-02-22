import SwiftUI

public struct PickerPageView<Content>: View where Content: View {
    @Binding public var currentIndex: Int
    var pages: Int
    var spacing: CGFloat = 0.8
    var content: () -> Content

    public init(
        spacing: CGFloat? = nil,
        pages: Int = 0,
        currentIndex: Binding<Int>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.spacing = spacing ?? 0.8
        self.pages = pages
        _currentIndex = currentIndex
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
            .onAppear {
                let value = currentIndex
                currentIndex = -1
                DispatchQueue.main.async {
                    currentIndex = value
                }
            }
            .frame(maxHeight: .infinity)
        }
    }
}

struct PickerPageView_Previews: PreviewProvider {
    static var previews: some View {
        PickerPageView(pages: 3, currentIndex: .constant(0), content: {
            Text("One")
            Text("Two")
            Text("Three")
        })
    }
}
