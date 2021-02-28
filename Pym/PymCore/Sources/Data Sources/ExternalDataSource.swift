import Foundation

public protocol ExternalDataSource {
    func getEvents(from _: Date, until _: Date) -> [ExternalEvent]
}
