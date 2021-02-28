import PymCore
import SwiftUI

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
