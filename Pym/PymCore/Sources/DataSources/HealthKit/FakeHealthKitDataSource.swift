import Foundation

public class FakeHealthKitDataSource: ExternalDataSource {
    public var sourceName = "HealthKit"

    private var eventMemory: [Date: [ExternalEvent]] = [:]
    private let possibleActivities: [String] = [
        "Workout",
        "Running",
        "Skiing",
        "Walking",
        "Climbing"
    ]

    public func getEvents(from startDate: Date, until endDate: Date) -> [ExternalEvent] {
        var events: [ExternalEvent] = []
        for date in iterateDays(from: startDate, until: endDate) {
            if let index = eventMemory.index(forKey: date) {
                events.append(contentsOf: eventMemory[index].value)
            } else {
                var newEvents: [ExternalEvent] = []
                for _ in 1 ... Int.random(in: 1 ... 5) {
                    newEvents.append(ExternalEvent(
                        id: UUID(),
                        title: possibleActivities.shuffled().first!,
                        timestamp: date
                            .adding(.hour, value: Int.random(in: 0 ... 23))
                            .adding(.minute, value: Int.random(in: 0 ... 59))
                            .adding(.second, value: Int.random(in: 0 ... 59)),
                        content: "Distance: \(Double.random(in: 1 ... 25))"
                    ))
                }
                eventMemory[date] = newEvents
                events.append(contentsOf: newEvents)
            }
        }
        return events
    }

    private func iterateDays(from startDate: Date, until endDate: Date) -> [Date] {
        var days: [Date] = []
        var currentDate = startDate.beginning(of: .day)!
        let endDay = endDate.beginning(of: .day)!
        while currentDate.unixTimestamp < endDay.unixTimestamp {
            days.append(currentDate)
            currentDate = currentDate.adding(.day, value: 1)
        }
        return days
    }
}