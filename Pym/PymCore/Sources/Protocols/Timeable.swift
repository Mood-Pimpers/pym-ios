import Foundation

public protocol Timeable {
    var id: UUID { get }
    var timestamp: Date { get }
}
