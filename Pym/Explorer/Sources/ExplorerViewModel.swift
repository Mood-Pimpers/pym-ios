import HorizonCalendar
import PymCore
import SwiftUI

class ExplorerViewModel: ObservableObject {
    @Published var selectedDay: Day? {
        didSet {
            if selectedDay != oldValue {
                selectedDate = selectedDay?.date
            }
        }
    }

    @Published var selectedDate: Date?

    let calendarStartDate = /* DataAccessController.shared.getEarliestEntry()?.date ?? Date() */ Date().adding(.month, value: -1)
    let calendarEndDate = Date()

    func getMoodRatingsFor(day: Date) -> [MoodRating] {
//        DataAccessController.shared
//            .getEntries(fromDay: day)
//            .map(\.rating)
        switch day.day % 5 {
        case 0:
            return [.great, .good]
        case 1:
            return [.bad, .poor]
        case 2:
            return [.moderate]
        default:
            return []
        }
    }

    func getIncidents(forDay day: Date) -> [IncidentContainer] {
        var incidents: [IncidentContainer] = [] /* DataAccessController.shared.getEntries(fromDay: day) */
        incidents.append(IncidentContainer(incident: MoodEntry(
            date: day,
            rating: MoodRating.allCases.randomElement()!,
            feelings: [.amazed, .clear],
            activities: ["University", "Work"]
        )
        ))

        incidents.append(contentsOf: ExternalDataAccess.shared.getEvents(fromDay: day).map { IncidentContainer(incident: $0) })
        return incidents
    }
}
