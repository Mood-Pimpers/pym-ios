import PymCore
import SwiftUI

// TODO: Use real images
extension MoodRating {
    var image: Image {
        switch self {
        case .bad: return Image(systemName: "person")
        case .poor: return Image(systemName: "person")
        case .moderate: return Image(systemName: "person")
        case .good: return Image(systemName: "person")
        case .great: return Image(systemName: "person")
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
