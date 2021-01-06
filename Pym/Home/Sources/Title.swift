import SwiftUI

public struct Title: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }

    public var body: some View {
        HStack {
            Text(text)
                .bold()
                .font(.title)
            Spacer()
        }
        .padding(EdgeInsets(top: 16 + 8, leading: 16, bottom: 8, trailing: 16))
    }
}
