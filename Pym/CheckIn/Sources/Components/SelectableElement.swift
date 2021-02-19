import SwiftUI

struct SelectableElement<TContent>: View where TContent: View {
    let isSelected: Bool
    let content: TContent
    let action: () -> Void

    init(isSelected: Bool, @ViewBuilder content: () -> TContent, action: @escaping () -> Void) {
        self.isSelected = isSelected
        self.content = content()
        self.action = action
    }

    var body: some View {
        content
            .frame(width: 64, height: 64)
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
