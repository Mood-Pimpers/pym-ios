import Foundation

public struct ExternalEvent: Equatable, Timeable {
    public let id: UUID
    public let title: String
    public let timestamp: Date
    public let source: ExternalDataSourceIdentifier
    public let content: Any

    public init(title: String, at timestamp: Date, from source: ExternalDataSourceIdentifier, with content: Any) {
        id = UUID()
        self.title = title
        self.timestamp = timestamp
        self.source = source
        self.content = content
    }

    public static func == (lhs: ExternalEvent, rhs: ExternalEvent) -> Bool {
        lhs.id.uuidString == rhs.id.uuidString
    }
}
