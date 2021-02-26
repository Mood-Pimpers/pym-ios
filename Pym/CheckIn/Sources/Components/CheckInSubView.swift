import PymCore
import SwiftUI

struct CheckInSubView<Content>: View where Content: View {
    let title: String
    let content: () -> Content
    let buttonText: String
    let next: () -> Void
    let canNext: () -> Bool

    init(
        title: String,
        @ViewBuilder content: @escaping () -> Content,
        buttonText: String,
        next: @escaping () -> Void,
        canNext: @escaping () -> Bool = { true }
    ) {
        self.title = title
        self.content = content
        self.buttonText = buttonText
        self.next = next
        self.canNext = canNext
    }

    var body: some View {
        VStack {
            Title(title)
            content()
            Spacer()

            Button(action: next, label: {
                Text(buttonText)
                    .bold()
                Spacer()
                Image(systemName: "arrow.right")
            })
                .buttonStyle(PrimaryButtonStyle())
                .disabled(!canNext())
        }
        .padding(16)
    }
}
