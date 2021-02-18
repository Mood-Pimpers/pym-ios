import Foundation

public class MoodEntry {
    let id: UUID
    let date: Date
    let rating: MoodRating
    let feelings: [Feeling]
    let activities: [String]

    init(id: UUID, date: Date, rating: MoodRating, feelings: [Feeling], activities: [String]) {
        self.id = id
        self.date = date
        self.rating = rating
        self.feelings = feelings
        self.activities = activities
    }
}
