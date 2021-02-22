import PymCore
import SwiftUI

struct ActivityView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var selectedActivities: [String] = []

    // TODO: Load activities from core data
    private let activities = [
        "work",
        "friends",
        "school"
    ]

    private func activitySelectable(_ activity: String, _ geometry: GeometryProxy) -> some View {
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
            width: geometry.size.width / 2 - 16 - 4
        )
    }

    public var body: some View {
        GeometryReader { geometry in
            VStack {
                Title("Why are you feeling this way?")
                TwoColumnView(elements: activities) { activity in
                    activitySelectable(activity, geometry)
                }

                Spacer()

                Button(action: finish, label: {
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
        if !selectedActivities.contains(activity) {
            selectedActivities.append(activity)
        }
    }

    private func finish() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
