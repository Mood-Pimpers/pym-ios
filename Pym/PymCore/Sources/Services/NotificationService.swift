import SwiftUI

public enum NotificationAuthorizationStatus {
    case notAsked
    case allowed
    case notAllowed
}

public enum Notification {
    public enum Identifier: String {
        case notifyMorning = "notify.morning"
        case notifyEvening = "notify.evening"
    }
}

public class NotificationService {
    public static let shared = NotificationService()
    private let notificationCenter = UNUserNotificationCenter.current()

    public var morningNotification: UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Good morning"
        content.subtitle = "Enter your morning entry"
        content.sound = UNNotificationSound.default
        return content
    }

    public var eveningNotification: UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Good evening"
        content.subtitle = "Enter your evening entry"
        content.sound = UNNotificationSound.default
        return content
    }

    private init() {}

    public func requestAuthorization(completion: @escaping (_ status: NotificationAuthorizationStatus) -> Void) {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                completion(.allowed)
            } else if let error = error {
                completion(.notAllowed)
                print(error.localizedDescription)
            } else {
                completion(.notAllowed)
            }
        }
    }

    public func schedule(identifier: Notification.Identifier, on time: Date, content: UNMutableNotificationContent) {
        var date = DateComponents()
        date.hour = time.hour
        date.minute = time.minute

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: date,
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: identifier.rawValue,
            content: content,
            trigger: trigger
        )

        notificationCenter.add(request)
    }

    public func remove(withIdentifier identifier: Notification.Identifier) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier.rawValue])
    }

    public func scheduleNotifyMorning(isEnabled: Bool, on time: Date) {
        remove(withIdentifier: Notification.Identifier.notifyMorning)
        if isEnabled {
            schedule(identifier: Notification.Identifier.notifyMorning, on: time, content: morningNotification)
        }
    }

    public func scheduleNotifyEvening(isEnabled: Bool, on time: Date) {
        remove(withIdentifier: Notification.Identifier.notifyEvening)
        if isEnabled {
            schedule(identifier: Notification.Identifier.notifyEvening, on: time, content: eveningNotification)
        }
    }
}
