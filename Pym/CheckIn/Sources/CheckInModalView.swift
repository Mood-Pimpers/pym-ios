import PymCore
import SwiftUI

public struct CheckInModalView: View {
    @Environment(\.presentationMode) var presentationMode

    public init() {}

    public var body: some View {
        VStack {
            CheckInView(onClose: save)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColor)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            // presentationMode.wrappedValue.dismiss()
        }
    }

    private func save(entry _: MoodEntry) {
        // TODO: Save entry
        presentationMode.wrappedValue.dismiss()
    }
}
