//
//  NotificationService.swift
//  ExpenseTrackerApp
//
//  Created by Hieu Dang on 7/17/24.
//
import UserNotifications
class NotificationService {
    static let notification = NotificationService()
    func scheduleNotification(budget: Double, totalSpent: Double) {
        let content = UNMutableNotificationContent()
        content.title = "Budget Alert"
        content.body = "You have spent \(totalSpent) which is more than your budget of \(budget)."
        content.sound = UNNotificationSound.default

        // Create a trigger for the notification - for immediate notification use timeInterval 20 second
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)

        // Create the request
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // Schedule the request with the system
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Permission granted")
            } else if let error = error {
                print("Permission denied: \(error.localizedDescription)")
            }
        }
    }
}
