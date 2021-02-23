struct Pair<Element>: Hashable where Element: Hashable {
    let first: Element
    let second: Element?
}

struct PairSequence<S: Sequence>: IteratorProtocol, Sequence where S.Element: Hashable {
    var iterator: S.Iterator

    init(seq: S) {
        iterator = seq.makeIterator()
    }

    mutating func next() -> Pair<S.Element>? {
        guard let first = iterator.next() else { return nil }
        let second = iterator.next()
        return Pair(first: first, second: second)
    }
}

extension Sequence where Self.Element: Hashable {
    func pairs() -> PairSequence<Self> {
        PairSequence(seq: self)
    }
}
