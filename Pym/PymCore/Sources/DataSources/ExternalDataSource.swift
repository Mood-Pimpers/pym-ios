import Foundation

public protocol ExternalDataSource {
    var sourceName: String { get }

    func getEvents(from _: Date, until _: Date) -> [ExternalEvent]
}
