import PymCore
import SwiftUI

struct MoodEntryCard: View {
    let imageSideLength: CGFloat
    let spacing: CGFloat
    let moodEntry: MoodEntry

    var body: some View {
        HStack(spacing: spacing) {
            moodEntry.rating.coloredImage
                .frame(width: imageSideLength, height: imageSideLength)

            ContentCard { alignment in
                alignment.top(.leading) {
                    Text("Mood Entry")
                        .contentCardTitle()
                }

                alignment.bottom(.leading) {
                    HStack(spacing: 15) {
                        ForEach(
                            Array(moodEntry.feelings)
                                .sorted { $0.description < $1.description },
                            id: \.self) {
                            Text($0.description)
                                .contentCardText()
                        }
                    }
                    .contentCardSubtitle()
                }

                alignment.top(.trailing) {
                    Text(moodEntry.timestamp.timeString(ofStyle: .short))
                        .contentCardText()
                        .contentCardTimePosition()
                }
            }
        }
    }
}

struct MoodEntryCard_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            VStack {
                MoodEntryCard(imageSideLength: 22.5, spacing: 15, moodEntry: MoodEntry(
                    date: Date(),
                    rating: .great,
                    feelings: [.clear, .amazed],
                    activities: ["University"]
                ))

                MoodEntryCard(imageSideLength: 22.5, spacing: 15, moodEntry: MoodEntry(
                    date: Date(),
                    rating: .good,
                    feelings: [.anxious, .enthusiastic],
                    activities: ["School"]
                ))

                MoodEntryCard(imageSideLength: 22.5, spacing: 15, moodEntry: MoodEntry(
                    date: Date(),
                    rating: .moderate,
                    feelings: [.confused, .distressed, .irritated],
                    activities: ["University", "Work"]
                ))

                MoodEntryCard(imageSideLength: 22.5, spacing: 15, moodEntry: MoodEntry(
                    date: Date(),
                    rating: .poor,
                    feelings: [.scared, .angry],
                    activities: ["University"]
                ))

                MoodEntryCard(imageSideLength: 22.5, spacing: 15, moodEntry: MoodEntry(
                    date: Date(),
                    rating: .bad,
                    feelings: [.sad, .upset, .worried],
                    activities: ["University"]
                ))
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.backgroundColor)
        }
    }
}
