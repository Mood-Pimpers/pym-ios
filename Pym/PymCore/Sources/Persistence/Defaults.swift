import Foundation

public extension UserDefaults {
    enum Keys: String, CaseIterable {
        case firstAppLaunch

        case wasNotificationAuthRequested

        case notifyMorningEnabled
        case notifyMorningTime

        case notifyEveningEnabled
        case notifyEveningTime
    }
}

public extension UserDefaults {
    var wasNotificationAuthRequested: Bool {
        bool(forKey: Keys.wasNotificationAuthRequested.rawValue)
    }

    func setNotificationAuthRequested() {
        set(true, forKey: Keys.wasNotificationAuthRequested.rawValue)
    }

    var notifyMorningEnabled: Bool {
        bool(forKey: Keys.notifyMorningEnabled.rawValue)
    }

    var notifyMorningTime: Date {
        object(forKey: Keys.notifyMorningTime.rawValue) as? Date ?? time(hour: 9)
    }

    func setNotifyMorning(isEnabled: Bool, on time: Date) {
        set(isEnabled, forKey: Keys.notifyMorningEnabled.rawValue)
        set(time, forKey: Keys.notifyMorningTime.rawValue)
    }

    var notifyEveningEnabled: Bool {
        bool(forKey: Keys.notifyEveningEnabled.rawValue)
    }

    var notifyEveningTime: Date {
        object(forKey: Keys.notifyEveningTime.rawValue) as? Date ?? time(hour: 21)
    }

    func setNotifyEvening(isEnabled: Bool, on time: Date) {
        set(isEnabled, forKey: Keys.notifyEveningEnabled.rawValue)
        set(time, forKey: Keys.notifyEveningTime.rawValue)
    }

    private func time(hour: Int, minute: Int = 0) -> Date {
        var date = Date()
        date.hour = hour
        date.minute = minute

        return date
    }
}
