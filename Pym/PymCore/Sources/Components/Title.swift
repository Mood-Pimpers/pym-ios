import SwiftUI

public struct Title: View {
    let text: String

    public init(_ text: String) {
        self.text = text
    }

    public var body: some View {
        HStack {
            Text(text)
                .bold()
                .font(.title)
            Spacer()
        }
    }
}

struct Title_Previews: PreviewProvider {
    static var previews: some View {
        Title("Nicer title")
    }
}
