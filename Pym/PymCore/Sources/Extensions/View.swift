import SwiftUI

public extension View {
    func disableDrag(when condition: () -> Bool = { true }) -> some View {
        gesture(condition() ? DragGesture() : nil)
    }
}
