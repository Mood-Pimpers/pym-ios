import Foundation
import HorizonCalendar

extension Day {
    var date: Date {
        let components = self.components
        var date = Date(era: components.era)!
        date.year = components.year!
        date.month = components.month!
        date.day = components.day!
        return date
    }
}
