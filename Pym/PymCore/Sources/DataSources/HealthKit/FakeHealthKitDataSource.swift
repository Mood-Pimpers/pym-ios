import Foundation

public class FakeHealthKitDataSource: ExternalDataSource {
    public var sourceName = "HealthKit"

    private var eventMemory: [Date: [ExternalEvent]] = [:]
    private let possibleActivities: [Activity] = [
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
                let newEvents = (1 ... Int.random(in: 1 ... 5))
                    .map { _ in
                        ExternalEvent(
                            id: UUID(),
                            title: possibleActivities[Int.random(in: 0 ... possibleActivities.count - 1)],
                            timestamp: date
                                .adding(.hour, value: Int.random(in: 0 ... 23))
                                .adding(.minute, value: Int.random(in: 0 ... 59))
                                .adding(.second, value: Int.random(in: 0 ... 59)),
                            content: "Distance: \(Double.random(in: 1 ... 25))"
                        )
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
