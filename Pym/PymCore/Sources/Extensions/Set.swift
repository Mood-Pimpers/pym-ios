extension Set {
    /// - Returns a new set with the given element inserted
    func inserting(_ element: Element) -> Set<Element> {
        var set = self
        set.insert(element)
        return set
    }
}
