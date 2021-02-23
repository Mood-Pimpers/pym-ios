import Foundation

public class MoodEntry {
    public var id: UUID
    public let date: Date
    public let rating: MoodRating
    public let feelings: [Feeling]
    public let activities: [String]

    private init(id: UUID, date: Date, rating: MoodRating, feelings: [Feeling], activities: [String]) {
        self.id = id
        self.date = date
        self.rating = rating
        self.feelings = feelings
        self.activities = activities
    }

    convenience init(date: Date, rating: MoodRating, feelings: [Feeling], activities: [String]) {
        self.init(id: UUID(), date: date, rating: rating, feelings: feelings, activities: activities)
    }

    convenience init(from model: MoodEntryModel) {
        self.init(id: model.id,
                  date: model.date,
                  rating: model.rating,
                  feelings: model.feelings,
                  activities: model.activities.compactMap(\.name))
    }
}
