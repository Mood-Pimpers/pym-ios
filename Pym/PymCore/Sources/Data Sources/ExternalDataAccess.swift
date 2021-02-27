import Foundation

public struct ExternalDataAccess {
    public static let shared = ExternalDataAccess()
    private let sources: [ExternalDataSource]

    private init() {
        sources = [
            FakeHealthKitDataSource()
        ]
    }

    public func getEvents(from startDate: Date, until endDate: Date) -> [ExternalEvent] {
        sources.flatMap { $0.getEvents(from: startDate, until: endDate) }
    }
}

public extension ExternalDataAccess {
    func getEvents(fromDay day: Date) -> [ExternalEvent] {
        // ! force-cast justified, since nil is only returned when an unsupported date-component is passed -> day is supported.
        getEvents(from: day.beginning(of: .day)!, until: day.end(of: .day)!)
    }
}
