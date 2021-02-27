import PymCore
import SwiftUI

struct IncidentView: View {
    let incident: IncidentContainer
    let imageSideLength: CGFloat = 22.5
    let cardSpacing: CGFloat = 12.5

    var body: some View {
        if let moodEntry = incident.incident as? MoodEntry {
            MoodEntryCard(
                imageSideLength: imageSideLength,
                spacing: cardSpacing,
                moodEntry: moodEntry
            )
        } else if let externalEvent = incident.incident as? ExternalEvent {
            if ExternalDataSourceIdentifier.healthKit == externalEvent.source {
                HealthKitCard(
                    imageSideLength: imageSideLength,
                    spacing: cardSpacing,
                    activity: externalEvent
                )
            }
        }
    }
}

struct IncidentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()

            IncidentView(incident: IncidentContainer(incident: MoodEntry(
                date: Date(),
                rating: .moderate,
                feelings: [.confused, .distressed, .irritated],
                activities: ["University", "Work"]
            )))

            Spacer()

            IncidentView(incident: IncidentContainer(incident: ExternalEvent(
                title: HealthKitActivity.skiing.description,
                at: Date(),
                from: .healthKit,
                with: (HealthKitActivity.skiing, 35.2, 6.31)
            )))

            Spacer()
        }
        .background(Color.backgroundColor)
    }
}
