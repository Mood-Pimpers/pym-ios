import SwiftUI

struct CalendarBackgroundLayer: View {
    var body: some View {
        Color.primaryColor
            .cornerRadius(25, corners: [.bottomLeft, .bottomRight])
    }
}

struct CalendarBackgroundLayer_Previews: PreviewProvider {
    static var previews: some View {
        CalendarBackgroundLayer()
    }
}
