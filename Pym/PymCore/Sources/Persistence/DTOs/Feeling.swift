import Foundation

public enum Feeling: Int, CaseIterable, Comparable {
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

    public static func < (lhs: Feeling, rhs: Feeling) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
