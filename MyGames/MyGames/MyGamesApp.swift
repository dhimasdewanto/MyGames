//
//  MyGamesApp.swift
//  MyGames
//
//  Created by Dhimas Dewanto on 20/11/21.
//

import SwiftUI

@main
struct MyGamesApp: App {
    /// Add this to run notification in foreground.
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    let persistenceController = PersistenceController.shared

    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            HomePage()
                // Set environment for context.
                .environment(
                    \.managedObjectContext,
                    persistenceController.container.viewContext
                )
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .background:
                print("Scene in Background")
                // If application in background, save data.
                persistenceController.save()
            case .inactive:
                print("Scene in Inactive")
            case .active:
                print("Scene in Active")
            @unknown default:
                print("Unknown Default")
            }
        }
    }
}

/// Add this to enable notification in foreground.
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
}

/// Add this to enable notification in foreground.
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        /// Here we actually handle the notification.
        print("Notification received with identifier \(notification.request.identifier)")
        /// So we call the completionHandler telling that
        /// the notification should display a banner and play the notification sound -
        /// this will happen while the app is in foreground.
        completionHandler([.banner, .sound])
    }
}
