import PymCore
import SwiftUI

extension MoodRating {
    var coloredImage: some View {
        let image = self.image
        switch self {
        case .great, .good, .moderate:
            return image.resizable().foregroundColor(.greenGradientEnd)
        case .poor, .bad:
            return image.resizable().foregroundColor(.redGradientEnd)
        }
    }
}
