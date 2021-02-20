import Foundation

extension MoodEntryModel {
    var rating: MoodRating {
        get {
            MoodRating(rawValue: ratingValue)!
        }
        set(newRating) {
            ratingValue = newRating.rawValue
        }
    }
}
