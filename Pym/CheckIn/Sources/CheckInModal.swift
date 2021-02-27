import PymCore
import SwiftUI

public struct CheckInModal: View {
    @Environment(\.presentationMode) var presentationMode

    public init() {}

    public var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            CheckInView(onClose: close)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.top)
    }

    private func close(entry _: MoodEntry) {
        presentationMode.wrappedValue.dismiss()
    }
}
