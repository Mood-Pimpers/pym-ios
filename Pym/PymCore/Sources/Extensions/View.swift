import SwiftUI

public extension View {
    func disableDrag(when condition: () -> Bool) -> some View {
        gesture(condition() ? DragGesture() : nil)
    }
}
