import PymCore
import SwiftUI

struct ActivityView: View {
    let activities: Set<Activity>
    let next: (_ activities: Set<Activity>) -> Void

    @State private var selectedActivities: Set<Activity> = []

    private func activitySelectable(_ activity: Activity, _ width: CGFloat) -> some View {
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
                    elements: Array(activities),
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
        next(selectedActivities)
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(activities: ["work", "school"]) { print($0) }
    }
}
