import PymCore
import SwiftUI

struct ActivityView: View {
    @Environment(\.presentationMode) var presentationMode

    public var body: some View {
        VStack {
            Title("Why are you feeling this way?")
            Spacer()

            Button(action: finish, label: {
                Text("finish")
                    .bold()
                Spacer()
            })
                .buttonStyle(PrimaryButtonStyle())
                .padding(16)
        }
    }

    private func finish() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
