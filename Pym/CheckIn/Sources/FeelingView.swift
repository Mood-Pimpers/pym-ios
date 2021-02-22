import PymCore
import SwiftUI

struct Feeling: Hashable {
    let color: Color
    let name: String
}

struct PairElement<Element>: Hashable where Element: Hashable {
    let first: Element
    let second: Element?
}

struct PairSequence<S: Sequence>: IteratorProtocol, Sequence where S.Element: Hashable {
    var iterator: S.Iterator

    init(seq: S) {
        iterator = seq.makeIterator()
    }

    mutating func next() -> PairElement<S.Element>? {
        guard let first = iterator.next() else { return nil }
        let second = iterator.next()
        return PairElement(first: first, second: second)
    }
}

extension Sequence where Self.Element: Hashable {
    func pairs() -> PairSequence<Self> {
        PairSequence(seq: self)
    }
}

struct FeelingView: View {
    @StateObject var viewRouter: CheckInViewRouter

    @State var selectedFeelings: [String] = []

    private let feelings = [
        Feeling(color: Color.red, name: "angry"),
        Feeling(color: Color.red, name: "upset"),
        Feeling(color: Color.red, name: "irritated"),
        Feeling(color: Color.orange, name: "clear"),
        Feeling(color: Color.orange, name: "curious"),
        Feeling(color: Color.orange, name: "enthusiastic"),
        Feeling(color: Color.yellow, name: "happy"),
        Feeling(color: Color.yellow, name: "relaxed")
    ]

    private func feelingSelectable(feeling: Feeling, geometry: GeometryProxy) -> some View {
        SelectableElement(
            isSelected: selectedFeelings.contains(feeling.name),
            content: {
                Text(feeling.name)
                    .frame(maxWidth: geometry.size.width / 2)
            },
            action: {
                if !selectedFeelings.contains(feeling.name) {
                    selectedFeelings.append(feeling.name)
                }
            }
        )
        .padding(4)
        .frame(minWidth: geometry.size.width / 2)
    }

    public var body: some View {
        GeometryReader { geometry in
            VStack {
                Title("Describe your feelings?")

                ScrollView {
                    VStack {
                        ForEach(Array(feelings.pairs()), id: \.self) { feelingPairs in
                            HStack {
                                feelingSelectable(feeling: feelingPairs.first, geometry: geometry)

                                if let second = feelingPairs.second {
                                    feelingSelectable(feeling: second, geometry: geometry)
                                }
                            }
                        }
                    }
                }

                Spacer()

                Button(action: next, label: {
                    Text("continue")
                        .bold()
                    Spacer()
                })
                    .buttonStyle(PrimaryButtonStyle())
            }
            .padding(16)
        }
    }

    private func next() {
        viewRouter.currentPage = .activity
    }
}

struct FeelingView_Previews: PreviewProvider {
    static var previews: some View {
        FeelingView(viewRouter: CheckInViewRouter())
    }
}
