import PymCore
import SwiftUI

public extension Feeling {
    var color: Color {
        switch self {
        case .angry, .upset, .irritated: return Color.red
        case .clear, .curious, .enthusiastic: return Color.orange
        case .happy, .relaxed: return Color.yellow
        case .scared, .anxious, .worried: return Color.green
        case .amazed, .surprised, .confused: return Color.blue
        case .distressed, .sad: return Color.purple
        }
    }
}
