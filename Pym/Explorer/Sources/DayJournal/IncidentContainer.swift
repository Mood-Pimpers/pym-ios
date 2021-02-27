import Foundation
import PymCore

struct IncidentContainer: Identifiable {
    let incident: Timeable
    var id: UUID { incident.id }
    var timestamp: Date { incident.timestamp }
}
