import PymCore
import SwiftUI

// TODO: Rename to ActivityInput
struct ActivityView: View {
    @Binding var activities: Set<Activity>
    @Binding var allActivities: Set<Activity> // TODO: as array

    private func activitySelectable(_ activity: Activity, _ width: CGFloat) -> some View {
        SelectableElement(
            isSelected: activities.contains(activity),
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
        Columns(
            elements: Array(allActivities),
            columns: 2,
            content: activitySelectable
        )
    }

    private func select(_ activity: String) {
        activities.toggle(activity)
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(
            activities: Binding<Set<Activity>>.constant([]),
            allActivities: Binding<Set<Activity>>.constant(["Work", "University"])
        )
    }
}
