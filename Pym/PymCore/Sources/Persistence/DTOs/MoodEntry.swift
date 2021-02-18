import Foundation

public class MoodEntry: Identifiable {
    public let id: UUID
    public let date: Date
    public let rating: MoodRating
    public let feelings: [Feeling]
    public let activities: [String]

    init(id: UUID, date: Date, rating: MoodRating, feelings: [Feeling], activities: [String]) {
        self.id = id
        self.date = date
        self.rating = rating
        self.feelings = feelings
        self.activities = activities
    }
}
