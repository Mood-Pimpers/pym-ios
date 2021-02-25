import Foundation

public struct ExternalEvent: Identifiable, Equatable {
    public let id: UUID
    public let title: String
    public let timestamp: Date
    public let content: Any

    public static func == (lhs: ExternalEvent, rhs: ExternalEvent) -> Bool {
        lhs.id.uuidString == rhs.id.uuidString
    }
}
