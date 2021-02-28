import Foundation

public struct ExternalEvent: Identifiable, Equatable {
    public let id: UUID
    public let title: String
    public let timestamp: Date
    public let content: Any

    // todo: remove constructor when merging with main and adapt code in InsightsServices
    public init(title: String, at timestamp: Date, with content: Any) {
        id = UUID()
        self.title = title
        self.timestamp = timestamp
        self.content = content
    }

    public static func == (lhs: ExternalEvent, rhs: ExternalEvent) -> Bool {
        lhs.id.uuidString == rhs.id.uuidString
    }
}
