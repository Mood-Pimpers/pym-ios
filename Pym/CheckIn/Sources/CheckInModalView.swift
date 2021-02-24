import PymCore
import SwiftUI

public struct CheckInModalView: View {
    @Environment(\.presentationMode) var presentationMode

    public init() {}

    public var body: some View {
        VStack {
            CheckInView(onClose: close)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColor)
        .edgesIgnoringSafeArea(.all)
    }

    private func close(entry _: MoodEntry) {
        presentationMode.wrappedValue.dismiss()
    }
}
