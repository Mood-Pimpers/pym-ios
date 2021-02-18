import Foundation

public class MoodEntry {
    public var id: UUID?
    public let date: Date
    public let rating: MoodRating
    public let feelings: [Feeling]
    public let activities: [String]

    init(date: Date, rating: MoodRating, feelings: [Feeling], activities: [String]) {
        self.date = date
        self.rating = rating
        self.feelings = feelings
        self.activities = activities
    }

    convenience init(id: UUID, date: Date, rating: MoodRating, feelings: [Feeling], activities: [String]) {
        self.init(date: date, rating: rating, feelings: feelings, activities: activities)
        self.id = id
    }

    convenience init(from model: MoodEntryModel) {
        self.init(date: model.date,
                  rating: model.rating,
                  feelings: model.feelings,
                  activities: model.activities.filter { $0.name != nil }
                      .map { $0.name! })
        id = model.id
    }
}
