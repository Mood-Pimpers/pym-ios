import SwiftUI

struct SelectableElement<TContent>: View where TContent: View {
    let isSelected: Bool
    let content: TContent
    let action: () -> Void
    let width: CGFloat
    let height: CGFloat

    init(
        isSelected: Bool,
        @ViewBuilder content: () -> TContent,
        action: @escaping () -> Void,
        width: CGFloat = 64,
        height: CGFloat = 64
    ) {
        self.isSelected = isSelected
        self.content = content()
        self.action = action
        self.width = width
        self.height = height
    }

    var body: some View {
        content
            .frame(width: width, height: height)
            .background(isSelected ? Color.primaryColor : Color.white)
            .cornerRadius(4)
            .shadow(color: .neutralLightColor, radius: 8)
            .onTapGesture(perform: action)
    }
}

struct SelectableElement_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SelectableElement(
                isSelected: true,
                content: { Text("selected") },
                action: {}
            )

            SelectableElement(
                isSelected: false,
                content: { Text("not selected") },
                action: {}
            )
        }
    }
}
