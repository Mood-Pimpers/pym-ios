import Foundation
import SwiftUI

public enum MoodRating: Int16 {
    case bad = 1
    case poor
    case moderate
    case good
    case great
}

extension MoodRating: CaseIterable, Comparable {
    public static func < (lhs: MoodRating, rhs: MoodRating) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

public extension MoodRating {
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
