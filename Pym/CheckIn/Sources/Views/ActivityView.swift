import PymCore
import SwiftUI

struct ActivityView: View {
    let next: (_ activities: [String]) -> Void
    @State private var selectedActivities: Set<String> = []

    // TODO: Load activities from core data
    private let activities = [
        "work",
        "friends",
        "school"
    ]

    private func activitySelectable(_ activity: String, _ width: CGFloat) -> some View {
        SelectableElement(
            isSelected: selectedActivities.contains(activity),
            content: {
                HStack {
                    Text(activity)
                    Spacer()
                }
                .padding(8)
            },
            action: { select(activity) },
            width: width
        )
    }

    public var body: some View {
        GeometryReader { _ in
            VStack {
                Title("Why are you feeling this way?")
                Columns(
                    elements: activities,
                    columns: 2,
                    content: activitySelectable
                )

                Spacer()

                Button(action: callNext, label: {
                    Text("finish")
                        .bold()
                    Spacer()
                })
                    .buttonStyle(PrimaryButtonStyle())
            }
            .padding(16)
        }
    }

    private func select(_ activity: String) {
        selectedActivities.toggle(activity)
    }

    private func callNext() {
        next(Array(selectedActivities))
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView { print($0) }
    }
}
