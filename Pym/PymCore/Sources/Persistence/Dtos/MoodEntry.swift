import Foundation

public class MoodEntry: Timeable {
    public var id: UUID
    public let timestamp: Date
    public let rating: MoodRating
    public let feelings: Set<Feeling>
    public let activities: Set<Activity>

    private init(id: UUID, timestamp: Date, rating: MoodRating, feelings: Set<Feeling>, activities: Set<Activity>) {
        self.id = id
        self.timestamp = timestamp
        self.rating = rating
        self.feelings = feelings
        self.activities = activities
    }

    public convenience init() {
        self.init(id: UUID(), timestamp: Date(), rating: MoodRating.moderate, feelings: [], activities: [])
    }

    public convenience init(date: Date, rating: MoodRating, feelings: Set<Feeling>, activities: Set<Activity>) {
        self.init(id: UUID(), timestamp: date, rating: rating, feelings: feelings, activities: activities)
    }

    public convenience init(from model: MoodEntryModel) {
        self.init(id: model.id,
                  timestamp: model.date,
                  rating: model.rating,
                  feelings: model.feelings,
                  activities: Set(model.activities.compactMap(\.name)))
    }
}
