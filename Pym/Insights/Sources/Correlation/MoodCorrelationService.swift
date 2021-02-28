import PymCore

struct MoodCorrelationService {
    static let shared = MoodCorrelationService()

    private init() {}

    /**
      Calculates the correlation between MoodEntries and ExternalEvents.

      - Returns: A dictionary containing a correlation value per activity. The correlation values are within the range [-1;1].
     */
    func calculateCorrelations(of moodEntries: [MoodEntry], with events: [ExternalEvent]) -> [Activity: Double] {
        var flattenedEntries = moodEntries.flatMap { entry in
            entry.activities.map { activity in (activity, entry.rating) }
        }

        flattenedEntries.append(contentsOf: events.compactMap { event -> (Activity, MoodRating)? in
            let entryTimeDistances = moodEntries
                .filter { $0.timestamp.beginning(of: .day) == event.timestamp.beginning(of: .day) }
                .map { ($0, abs($0.timestamp.distance(to: event.timestamp))) }
                .sorted { $0.1 < $1.1 }

            if let closedEntry = entryTimeDistances.first {
                return (event.title, closedEntry.0.rating)
            } else {
                // no entry was tracked on the same date
                return nil
            }
        })

        return Dictionary(grouping: flattenedEntries) { $0.0 }
            .mapValues { ratings -> Double in
                let ratingsSum = ratings
                    .map { Double($0.1.rawValue - 3) / Double(2) } // linearize mood values to range [-1;1]
                    .reduce(0, +)

                return ratingsSum / Double(ratings.count)
            }
    }
}
