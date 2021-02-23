import PymCore
import SwiftUI

extension MoodRating {
    var image: Image {
        switch self {
        case .bad: return Image.moodBad
        case .poor: return Image.moodPoor
        case .moderate: return Image.moodModerate
        case .good: return Image.moodGood
        case .great: return Image.moodGreat
        }
    }
}

extension MoodRating: CustomStringConvertible {
    public var description: String {
        switch self {
        case .bad: return "bad"
        case .poor: return "poor"
        case .moderate: return "moderate"
        case .good: return "good"
        case .great: return "great"
        }
    }
}
