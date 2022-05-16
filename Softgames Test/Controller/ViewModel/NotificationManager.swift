//
//  NotificationManager.swift
//  Softgames Test
//
//  Created by Pratikkumar Prajapati on 16/05/22.
//

import Foundation
import UserNotifications

final class NotificationManager {
    
    internal let notificationCenter = UNUserNotificationCenter.current()
    
    static let shared = NotificationManager()
    
    var clouserStatusError: (() -> Void)?
    
    private init() {
        
    }
    
    private func requestNotificationAccess() {
                        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
    }
    
    func notificationAccessStatus(delegate: UNUserNotificationCenterDelegate) {
        notificationCenter.delegate = delegate
        notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .notDetermined {
                self.requestNotificationAccess()
            } else if settings.authorizationStatus != .authorized {
                // Notifications not allowed
                DispatchQueue.main.async {
                    self.clouserStatusError?()
                }
            }
        }
        
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Solitaire smash"
        content.subtitle = "Play again to smash your top score"
        content.sound = UNNotificationSound.default
        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 7, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
}
