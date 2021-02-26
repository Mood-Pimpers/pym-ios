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

extension MoodEntryModel {
    typealias ReduceState = (remainingValue: Int32, feelings: Set<Feeling>)

    var feelings: Set<Feeling> {
        get {
            Feeling.allCases
                .sorted { $0 > $1 }
                .reduce(ReduceState(feelingsValue, [])) { state, feeling in
                    feeling.rawValue <= state.remainingValue
                        ? ReduceState(
                            state.remainingValue - Int32(feeling.rawValue),
                            state.feelings.inserting(feeling)
                        )
                        : state
                }
                .feelings
        }
        set(newFeelings) {
            feelingsValue = Int32(newFeelings.reduce(0) { $0 + $1.rawValue })
        }
    }
}
