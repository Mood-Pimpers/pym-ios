import HorizonCalendar
import SwiftUI

class CalendarModel: ObservableObject {
    @Published var selectedDay: Day? {
        didSet {
            selectedDate = oldValue?.date
        }
    }

    @Published var selectedDate: Date?
}
