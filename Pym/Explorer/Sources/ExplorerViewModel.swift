import HorizonCalendar
import PymCore
import SwiftUI

class ExplorerViewModel: ObservableObject {
    init() {
        DataAccessController.shared.addChangeListener { [weak self] in
            if self != nil,
               self?.selectedDate?.beginning(of: .day) == $0.beginning(of: .day) {
                self?.selectedDate = $0
            }
        }
    }

    @Published var selectedDay: Day? {
        didSet {
            if selectedDay != oldValue {
                selectedDate = selectedDay?.date
            }
        }
    }

    @Published var selectedDate: Date?

    let calendarStartDate = DataAccessController.shared.getEarliestEntry()?.timestamp ?? Date()
    let calendarEndDate = Date()

    func getMoodRatingsFor(day: Date) -> [MoodRating] {
        DataAccessController.shared
            .getEntries(fromDay: day)
            .map(\.rating)
    }

    func getIncidents(forDay day: Date) -> [IncidentContainer] {
        var incidents: [IncidentContainer] = DataAccessController.shared
            .getEntries(fromDay: day)
            .map { IncidentContainer(incident: $0) }

        incidents.append(contentsOf: ExternalDataAccess.shared
            .getEvents(fromDay: day)
            .map { IncidentContainer(incident: $0) }
        )

        return incidents
    }
}
