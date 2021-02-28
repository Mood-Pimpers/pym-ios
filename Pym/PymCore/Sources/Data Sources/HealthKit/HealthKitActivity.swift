public enum HealthKitActivity {
    case running
    case skiing
    case swimming
}

extension HealthKitActivity: CaseIterable {}

extension HealthKitActivity: CustomStringConvertible {
    public var description: String {
        switch self {
        case .running:
            return "Running"
        case .skiing:
            return "Skiing"
        case .swimming:
            return "Swimming"
        }
    }
}
