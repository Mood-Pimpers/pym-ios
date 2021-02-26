import Foundation

public enum Defaults {
    /// User Defaults Keys
    public struct Keys {
        private init() {}

        public static let firstAppLaunch = "firstAppLaunch"

        public static let wasNotificationAuthRequested = "wasNotificationAuthRequested"

        public static let notifyMorningEnabled = "notify.morning.enabled"
        public static let notifyMorningTime = "notify.morning.time"

        public static let notifyEveningEnabled = "notify.evening.enabled"
        public static let notifyEveningTime = "notify.evening.time"
    }
}

public extension UserDefaults {
    var notifyMorningEnabled: Bool {
        bool(forKey: Defaults.Keys.notifyMorningEnabled)
    }

    var notifyMorningTime: Date {
        object(forKey: Defaults.Keys.notifyMorningTime) as? Date ?? time(hour: 9)
    }

    func setNotifyMorning(isEnabled: Bool, on time: Date) {
        set(isEnabled, forKey: Defaults.Keys.notifyMorningEnabled)
        set(time, forKey: Defaults.Keys.notifyMorningTime)
    }

    var notifyEveningEnabled: Bool {
        bool(forKey: Defaults.Keys.notifyEveningEnabled)
    }

    var notifyEveningTime: Date {
        object(forKey: Defaults.Keys.notifyEveningTime) as? Date ?? time(hour: 21)
    }

    func setNotifyEvening(isEnabled: Bool, on time: Date) {
        set(isEnabled, forKey: Defaults.Keys.notifyEveningEnabled)
        set(time, forKey: Defaults.Keys.notifyEveningTime)
    }

    private func time(hour: Int, minute: Int = 0) -> Date {
        var date = Date()
        date.hour = hour
        date.minute = minute

        return date
    }
}
