import SwiftUI

public struct PrimaryButton<Content>: View where Content: View {
    let content: () -> Content
    let action: () -> Void

    public init(action: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.action = action
    }

    public var body: some View {
        Button(action: self.action) {
            HStack(alignment: .center) {
                content()
            }
        }
        .padding(16)
        .background(Color.primaryColor)
        .foregroundColor(.black)
        .cornerRadius(8.0)
        .shadow(color: Color.dropShadowColor, radius: 8, x: 0, y: 4)
    }
}
