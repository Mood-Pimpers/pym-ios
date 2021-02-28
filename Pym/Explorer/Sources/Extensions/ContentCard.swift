import SwiftUI

extension Text {
    func contentCardTitle() -> some View {
        font(.system(size: 20, weight: Font.Weight.bold))
            .padding([.top, .leading], 10)
    }

    func contentCardTimePosition() -> some View {
        padding([.top, .trailing], 10)
    }

    func contentCardText() -> Text {
        font(.system(size: 15, weight: Font.Weight.light))
    }
}

extension View {
    func contentCardSubtitle() -> some View {
        padding([.bottom, .leading], 10)
    }
}
