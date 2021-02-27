import PymCore
import SwiftUI

struct IncidentView: View {
    let incident: IncidentContainer
    let imageSideLength: CGFloat = 22.5
    let cardSpacing: CGFloat = 12.5

    var body: some View {
        if let moodEntry = incident.incident as? MoodEntry {
            MoodEntryCard(imageSideLength: imageSideLength, spacing: cardSpacing, moodEntry: moodEntry)
        }
    }
}

struct IncidentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()

            IncidentView(incident: IncidentContainer(incident: MoodEntry(date: Date(), rating: .great, feelings: [.clear, .amazed], activities: ["University"])))

            IncidentView(incident: IncidentContainer(incident: MoodEntry(date: Date(), rating: .good, feelings: [.anxious, .enthusiastic], activities: ["School"])))

            IncidentView(incident: IncidentContainer(incident: MoodEntry(date: Date(), rating: .moderate, feelings: [.confused, .distressed, .irritated], activities: ["University", "Work"])))

            IncidentView(incident: IncidentContainer(incident: MoodEntry(date: Date(), rating: .poor, feelings: [.scared, .angry], activities: ["University"])))

            IncidentView(incident: IncidentContainer(incident: MoodEntry(date: Date(), rating: .bad, feelings: [.sad, .upset, .worried], activities: ["University"])))

            Spacer()

            IncidentView(incident: IncidentContainer(incident: ExternalEvent(title: "Running", at: Date(), with: (5.3, 35, 6.31))))

            Spacer()
        }
        .background(Color.backgroundColor)
    }
}
