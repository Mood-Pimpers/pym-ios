import CoreData
import Foundation

public extension MoodEntryModel {
    var rating: MoodRating {
        get {
            MoodRating(rawValue: ratingValue)!
        }
        set(newRating) {
            ratingValue = newRating.rawValue
        }
    }

    var feelings: [Feeling] {
        get {
            var feelingsArr: [Feeling] = []

            var remainingFeelingsValue = feelingsValue
            Feeling.allCases
                .reduce(into: [Feeling]()) { copiedArray, feeling in copiedArray.append(feeling) }
                .sorted { (feeling1, feeling2) -> Bool in feeling1.rawValue > feeling2.rawValue }
                .forEach {
                    if $0.rawValue <= remainingFeelingsValue {
                        remainingFeelingsValue -= Int16($0.rawValue)
                        feelingsArr.append($0)
                    }
                }

            return feelingsArr
        }
        set(newFeelings) {
            feelingsValue = Int16(newFeelings.reduce(0) { $0 + $1.rawValue })
        }
    }
}
