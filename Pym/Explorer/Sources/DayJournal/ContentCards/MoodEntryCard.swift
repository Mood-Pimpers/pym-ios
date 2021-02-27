import PymCore
import SwiftUI

private extension MoodEntry {
    var ratingImage: some View {
        let image: Image
        switch rating {
        case .great:
            image = Image.moodGreat
        case .good:
            image = Image.moodGood
        case .moderate:
            image = Image.moodModerate
        case .poor:
            image = Image.moodPoor
        case .bad:
            image = Image.moodBad
        }

        switch rating {
        case .great, .good, .moderate:
            return image.resizable().foregroundColor(.chartPositiveColor)
        case .poor, .bad:
            return image.resizable().foregroundColor(.chartNegativeColor)
        }
    }

    var feelingsArray: [Feeling] {
        Array(feelings)
    }
}

struct MoodEntryCard: View {
    let imageSideLength: CGFloat
    let spacing: CGFloat
    let moodEntry: MoodEntry

    var body: some View {
        HStack(spacing: spacing) {
            moodEntry.ratingImage
                .frame(width: imageSideLength, height: imageSideLength)

            ContentCard { alignment in
                alignment.top(.leading) {
                    Text("Mood Entry")
                        .contentCardTitle()
                }

                alignment.bottom(.leading) {
                    HStack(spacing: 15) {
                        ForEach(moodEntry.feelingsArray.sorted(), id: \.self) {
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
                MoodEntryCard(imageSideLength: 22.5, spacing: 15, moodEntry: MoodEntry(date: Date(), rating: .great, feelings: [.angry], activities: ["University"]))
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.backgroundColor)
        }
    }
}
