import SwiftUI

public struct PrimaryButton: View {
    let label: String
    let action: () -> Void

    public init(label: String, action: @escaping () -> Void) {
        self.label = label
        self.action = action
    }

    public var body: some View {
        Button(action: self.action) {
            HStack(alignment: .center) {
                Text(self.label).bold()
            }
        }
        .padding(16)
        .background(Color.primaryColor)
        .foregroundColor(.black)
        .cornerRadius(8.0)
        .shadow(color: Color.dropShadowColor, radius: 8, x: 0, y: 4)
    }
}
