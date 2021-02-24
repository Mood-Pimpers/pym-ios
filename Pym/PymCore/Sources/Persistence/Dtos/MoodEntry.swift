import Foundation

public class MoodEntry {
    public var id: UUID
    public let date: Date
    public let rating: MoodRating
    public let feelings: Set<Feeling>
    public let activities: Set<String>

    private init(id: UUID, date: Date, rating: MoodRating, feelings: Set<Feeling>, activities: Set<String>) {
        self.id = id
        self.date = date
        self.rating = rating
        self.feelings = feelings
        self.activities = activities
    }

    public convenience init() {
        self.init(id: UUID(), date: Date(), rating: MoodRating.moderate, feelings: [], activities: [])
    }

    public convenience init(date: Date, rating: MoodRating, feelings: Set<Feeling>, activities: Set<String>) {
        self.init(id: UUID(), date: date, rating: rating, feelings: feelings, activities: activities)
    }

    public convenience init(from model: MoodEntryModel) {
        self.init(id: model.id,
                  date: model.date,
                  rating: model.rating,
                  feelings: [], // model.feelings,
                  activities: []) // model.activities.compactMap(\.name))
    }
}
