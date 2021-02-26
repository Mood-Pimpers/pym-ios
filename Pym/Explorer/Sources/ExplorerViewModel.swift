import HorizonCalendar
import PymCore
import SwiftUI

class CalendarViewModel: ObservableObject {
    @Published var selectedDay: Day? {
        didSet {
            if selectedDay != oldValue {
                selectedDate = selectedDay?.date
            }
        }
    }
    @Published var selectedDate: Date?

    let calendarStartDate = DataAccessController.shared.getEarliestEntry()?.date ?? Date()
    let calendarEndDate = Date()
}
