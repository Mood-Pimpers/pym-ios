import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
    public init() {}

    public func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        PrimaryButton(configuration: configuration)
    }

    struct PrimaryButton: View {
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool

        var body: some View {
            HStack {
                configuration.label
            }
            .foregroundColor(.black)
            .padding(15)
            .background(isEnabled ? Color.primaryColor : Color.neutralLightColor)
            .compositingGroup()
            .cornerRadius(8.0)
            .shadow(color: Color.dropShadowColor, radius: 8, x: 0, y: 4)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
        }
    }
}

struct PrimaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button(action: {}, label: { Text("Active Button") })
                .buttonStyle(PrimaryButtonStyle())

            Button(action: {}, label: { Text("Disabled Button") })
                .buttonStyle(PrimaryButtonStyle())
                .disabled(true)
        }
    }
}
