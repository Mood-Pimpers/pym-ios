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
