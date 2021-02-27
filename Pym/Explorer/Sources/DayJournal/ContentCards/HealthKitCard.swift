import PymCore
import SwiftUI

private extension Double {
    func formatWith(decimalPlaces places: Int) -> String {
        String(format: "%.\(places)f", self)
    }
}

private extension HealthKitActivity {
    var image: some View {
        let emoji: String
        switch self {
        case .running:
            emoji = "🏃‍♂️"
        case .skiing:
            emoji = "⛷"
        case .swimming:
            emoji = "🏊"
        }
        return Text(emoji)
    }
}

struct HealthKitCard: View {
    let imageSideLength: CGFloat
    let spacing: CGFloat
    let activity: ExternalEvent

    var body: some View {
        if let (healthKitActivity, distance, time) = activity.content as? (HealthKitActivity, Double, Double) {
            HStack(spacing: spacing) {
                healthKitActivity.image
                    .frame(width: imageSideLength, height: imageSideLength)

                ContentCard { alignment in
                    alignment.top(.leading) {
                        Text(activity.title).contentCardTitle()
                    }

                    alignment.bottom(.leading) {
                        HStack(spacing: 15) {
                            Text("\(distance.formatWith(decimalPlaces: 1))km").contentCardText()
                            Text("\(time.formatWith(decimalPlaces: 1))min").contentCardText()
                            Text("\((time / distance).formatWith(decimalPlaces: 1))min/km").contentCardText()
                        }
                        .contentCardSubtitle()
                    }

                    alignment.top(.trailing) {
                        Text(activity.timestamp.timeString(ofStyle: .short))
                            .contentCardText()
                            .contentCardTimePosition()
                    }
                }
            }
        } else {
            Text("unsupported content")
        }
    }
}

struct HealthKitCard_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            VStack {
                HealthKitCard(
                    imageSideLength: 22.5,
                    spacing: 15,
                    activity: ExternalEvent(
                        title: HealthKitActivity.running.description,
                        at: Date(),
                        from: .healthKit,
                        with: (HealthKitActivity.running, 5.3, 42.2)
                    )
                )

                HealthKitCard(
                    imageSideLength: 22.5,
                    spacing: 15,
                    activity: ExternalEvent(
                        title: HealthKitActivity.skiing.description,
                        at: Date(),
                        from: .healthKit,
                        with: (HealthKitActivity.skiing, 5.3, 42.2)
                    )
                )

                HealthKitCard(
                    imageSideLength: 22.5,
                    spacing: 15,
                    activity: ExternalEvent(
                        title: HealthKitActivity.swimming.description,
                        at: Date(),
                        from: .healthKit,
                        with: (HealthKitActivity.swimming, 5.3, 42.2)
                    )
                )
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.backgroundColor)
        }
    }
}
