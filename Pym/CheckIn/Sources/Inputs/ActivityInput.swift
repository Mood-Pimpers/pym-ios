import PymCore
import SwiftUI

struct ActivityInput: View {
    @Binding var activities: Set<Activity>
    @Binding var allActivities: [Activity]

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
            elements: allActivities,
            columns: 2,
            content: activitySelectable
        )
    }

    private func select(_ activity: String) {
        activities.toggle(activity)
    }
}

struct ActivityInput_Previews: PreviewProvider {
    static var previews: some View {
        ActivityInput(
            activities: Binding<Set<Activity>>.constant([]),
            allActivities: Binding<[Activity]>.constant(["Work", "University"])
        )
    }
}
