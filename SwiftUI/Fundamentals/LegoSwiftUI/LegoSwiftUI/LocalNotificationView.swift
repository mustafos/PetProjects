//
//  LocalNotificationView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 06.06.2024.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            } else {
                print("SUCCESS")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "FIRST NOTIFICATION"
        content.subtitle = "Yes, it is so easy!"
        content.body = "Some text about notification"
        content.sound = .default
        content.badge = 1
        
        // TIME
        let triggerTime = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // CALENDER
        var dateComponents = DateComponents()
        dateComponents.hour = 22
        dateComponents.minute = 20
        let triggerCalender = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // LOCATION
        let coordinates = CLLocationCoordinate2D(latitude: 50, longitude: 14)
        let region = CLCircularRegion(center: coordinates, radius: 100, identifier: UUID().uuidString)
        region.notifyOnEntry = true
        region.notifyOnExit = true
        let triggerLocation = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: triggerLocation) // Changed notification by Time, Calender and Location
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct NotificationView: View {
    var body: some View {
        VStack(spacing: 10) {
            Button {
                NotificationManager.instance.requestAuthorization()
            } label: {
                Text("Request Authorization")
            }
            
            Button {
                NotificationManager.instance.scheduleNotification()
            } label: {
                Text("Schedule Notification")
            }
            .onAppear {
                UIApplication.shared.applicationIconBadgeNumber = 0
            }
            
            Button("Cancel notification") {
                NotificationManager.instance.cancelNotification()
            }
        }
    }
}
