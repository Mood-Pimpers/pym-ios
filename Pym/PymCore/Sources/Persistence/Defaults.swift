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

    func removeAll() {
        Keys.allCases.forEach {
            removeObject(forKey: $0.rawValue)
        }
    }

    private func time(hour: Int, minute: Int = 0) -> Date {
        var date = Date()
        date.hour = hour
        date.minute = minute

        return date
    }
}
