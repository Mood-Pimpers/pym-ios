public enum Feeling: Int {
    case angry = 1
    case upset = 2
    case irritated = 4
    case clear = 8
    case curious = 16
    case enthusiastic = 32
    case happy = 64
    case relaxed = 128
    case scared = 256
    case anxious = 512
    case worried = 1028
    case amazed = 2056
    case surprised = 4112
    case confused = 8224
    case distressed = 16448
    case sad = 32896
}

extension Feeling: CaseIterable, Comparable {
    public static func < (lhs: Feeling, rhs: Feeling) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

extension Feeling: CustomStringConvertible {
    public var description: String {
        switch self {
        case .angry: return "angry"
        case .upset: return "upset"
        case .irritated: return "irritated"
        case .clear: return "clear"
        case .curious: return "curious"
        case .enthusiastic: return "enthusiastic"
        case .happy: return "happy"
        case .relaxed: return "relaxed"
        case .scared: return "scared"
        case .anxious: return "anxious"
        case .worried: return "worried"
        case .amazed: return "amazed"
        case .surprised: return "surprised"
        case .confused: return "confused"
        case .distressed: return "distressed"
        case .sad: return "sad"
        }
    }
}

import SwiftUI

public extension Feeling {
    var color: Color {
        switch self {
        case .angry, .upset, .irritated: return Color.red
        case .clear, .curious, .enthusiastic: return Color.orange
        case .happy, .relaxed: return Color.yellow
        case .scared, .anxious, .worried: return Color.green
        case .amazed, .surprised, .confused: return Color.blue
        case .distressed, .sad: return Color.purple
        }
    }
}
