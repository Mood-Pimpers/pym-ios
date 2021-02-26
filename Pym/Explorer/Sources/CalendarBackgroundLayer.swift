import SwiftUI

struct CalendarBackgroundLayer: View {
    var body: some View {
        Rectangle()
            .foregroundColor(Color.primaryColor)
            .cornerRadius(25, corners: [.bottomLeft, .bottomRight])
    }
}

struct CalendarBackgroundLayer_Previews: PreviewProvider {
    static var previews: some View {
        CalendarBackgroundLayer()
    }
}
