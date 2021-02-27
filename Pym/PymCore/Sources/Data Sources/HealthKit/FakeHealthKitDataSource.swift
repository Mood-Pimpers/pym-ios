import Foundation

public class FakeHealthKitDataSource: ExternalDataSource {
    private var eventMemory: [Date: [ExternalEvent]] = [:]

    public func getEvents(from startDate: Date, until endDate: Date) -> [ExternalEvent] {
        var events: [ExternalEvent] = []
        for date in iterateDays(from: startDate, until: endDate) {
            if let index = eventMemory.index(forKey: date) {
                events.append(contentsOf: eventMemory[index].value)
            } else {
                let newEvents = (1 ... Int.random(in: 1 ... 3))
                    .map { _ -> ExternalEvent in
                        let activity = HealthKitActivity.allCases.randomElement()!
                        return ExternalEvent(
                            title: activity.description,
                            at: date
                                .adding(.hour, value: Int.random(in: 0 ... 23))
                                .adding(.minute, value: Int.random(in: 0 ... 59))
                                .adding(.second, value: Int.random(in: 0 ... 59)),
                            from: .healthKit,
                            with: (activity, Double.random(in: 1 ... 25), Double(Int.random(in: 20 ... 55)))
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
        let endDay = endDate.end(of: .day)!
        while currentDate.unixTimestamp < endDay.unixTimestamp {
            days.append(currentDate)
            currentDate = currentDate.adding(.day, value: 1)
        }
        return days
    }
}
