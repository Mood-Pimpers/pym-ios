import SwiftUI

public enum NotificationAuthorizationStatus {
    case notAsked
    case allowed
    case error
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
                completion(.error)
                print(error.localizedDescription)
            } else {
                completion(.error)
            }
        }
    }

    public func schedule(identifier: String, on time: Date, content: UNMutableNotificationContent) {
        var date = DateComponents()
        date.hour = time.hour
        date.minute = time.minute

        print("\(date.hour):\(date.minute)")

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: date,
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )

        notificationCenter.add(request)
    }

    public func remove(withIdentifier id: String) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [id])
    }
}
