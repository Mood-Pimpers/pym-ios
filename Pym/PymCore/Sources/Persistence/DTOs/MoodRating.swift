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
