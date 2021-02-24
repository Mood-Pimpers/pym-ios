import SwiftUI

public extension View {
    func onSwipe(
        left: @escaping () -> Void,
        right: @escaping () -> Void
    ) -> some View {
        gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onEnded { value in
                if value.translation.width < 0 {
                    left()
                } else if value.translation.width > 0 {
                    right()
                }
            })
    }
}
