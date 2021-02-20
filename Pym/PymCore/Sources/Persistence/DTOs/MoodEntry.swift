import Foundation

public class MoodEntry {
    public var id: UUID?
    public let date: Date
    public let rating: MoodRating
    public let feelings: [Feeling]
    public let activities: [String]

    convenience init(date: Date, rating: MoodRating, feelings: [Feeling], activities: [String]) {
        self.init(id: nil, date: date, rating: rating, feelings: feelings, activities: activities)
    }

    init(id: UUID?, date: Date, rating: MoodRating, feelings: [Feeling], activities: [String]) {
        self.date = date
        self.rating = rating
        self.feelings = feelings
        self.activities = activities
        self.id = id
    }

    convenience init(from model: MoodEntryModel) {
        self.init(id: model.id,
                  date: model.date,
                  rating: model.rating,
                  feelings: model.feelings,
                  activities: model.activities.compactMap(\.name))
    }
}
