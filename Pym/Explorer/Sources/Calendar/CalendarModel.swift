import HorizonCalendar
import SwiftUI

class CalendarModel: ObservableObject {
    @Published var selectedDay: Day? {
        didSet {
            if selectedDay != oldValue {
                selectedDate = selectedDay?.date
            }
        }
    }

    @Published var selectedDate: Date?
}
