//
//  Notification.swift
//  MyCatalogueGames
//
//  Created by Dhimas Dewanto on 31/08/21.
//

import UserNotifications

/// Class to process notification.
class Notification {
    private var isGranted = false

    /// Check if permission to send notification is granted,
    /// then process to send notification.
    func sendNotification(
        title: String,
        subtitle: String
    ) {
        if !isGranted {
            requestPermissionAndProcess(
                title: title,
                subtitle: subtitle
            )
        } else {
            processNotification(
                title: title,
                subtitle: subtitle
            )
        }
    }

    /// Request permission to enable notification.
    /// Also try to process notification.
    private func requestPermissionAndProcess(
        title: String,
        subtitle: String
    ) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { isGranted, error in
            if isGranted {
                self.isGranted = true
                self.processNotification(
                    title: title,
                    subtitle: subtitle
                )
            } else if let error = error {
                print(error.localizedDescription)
                self.isGranted = false
            }
        }
    }

    /// Process to send notification.
    private func processNotification(
        title: String,
        subtitle: String
    ) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil
        )

        UNUserNotificationCenter.current().add(request) { error in
            print(error?.localizedDescription ?? "")
        }
    }
}
