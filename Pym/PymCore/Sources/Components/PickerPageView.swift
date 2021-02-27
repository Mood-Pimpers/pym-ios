import SwiftUI

public struct PickerPageView<Page, Content>: View where Page: Hashable & CaseIterable, Content: View {
    @Binding public var currentPage: Page
    var spacing: CGFloat = 8.0
    var content: () -> Content
    let disableDragWhen: () -> Bool

    public init(
        spacing: CGFloat? = nil,
        currentPage: Binding<Page>,
        disableDragWhen: @escaping () -> Bool = { true },
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.spacing = spacing ?? 8.0
        _currentPage = currentPage
        self.disableDragWhen = disableDragWhen
        self.content = content
    }

    public var body: some View {
        VStack {
            HStack(spacing: spacing) {
                ForEach(Array(Page.allCases), id: \.self) { page in
                    (page == currentPage ? Color.primaryColor : Color.neutralLightColor)
                        .cornerRadius(4)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 8.0)
            .padding(8)

            Spacer()
            TabView(selection: $currentPage) {
                content()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(Rectangle())
                    .gesture(disableDragWhen() ? DragGesture() : nil)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(maxHeight: .infinity)
        }
    }
}

struct PickerPageView_Previews: PreviewProvider {
    enum TestPage: CaseIterable {
        case one
        case two
        case three
    }

    static var previews: some View {
        PickerPageView(currentPage: .constant(TestPage.one)) {
            Text("One").tag(TestPage.one)
            Text("Two").tag(TestPage.two)
            Text("Three").tag(TestPage.three)
        }
    }
}
