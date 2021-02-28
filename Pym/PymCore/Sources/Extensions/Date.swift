import Foundation

public extension Date {
    func lastWeek() -> Date {
        adding(.weekOfYear, value: -1)
    }

    func nextWeek() -> Date {
        adding(.weekOfYear, value: 1)
    }
}
