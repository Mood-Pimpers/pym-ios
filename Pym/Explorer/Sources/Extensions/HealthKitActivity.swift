import PymCore
import SwiftUI

extension HealthKitActivity {
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
