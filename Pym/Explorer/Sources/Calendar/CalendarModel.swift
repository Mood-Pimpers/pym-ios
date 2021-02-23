import HorizonCalendar
import SwiftUI

class CalendarModel: ObservableObject {
    @Published var selectedDay: Day?
}
