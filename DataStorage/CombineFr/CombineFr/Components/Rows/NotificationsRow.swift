//
//  NotificationsRow.swift
//  CombineFr
//
//  Created by Mustafa Bekirov on 07.04.2023.
//

import SwiftUI

struct NotificationsRow: View {
    @StateObject var notificationVM = NotificationViewModel()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        Group {
            if notificationVM.permission == .authorized {
                Toggle(isOn: $notificationVM.subscribedToAllNotifications, label: {
                    HStack(spacing: 12) {
                        GradientIcon(icon: "bell.fill")
                        
                        VStack(alignment: .leading) {
                            Text("Notify me of new content")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            Text("Max once a week.")
                                .font(.caption2)
                                .opacity(0.7)
                        }
                    }
                })
                .toggleStyle(SwitchToggleStyle(tint: Color(#colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1))))
            } else {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Notifications are disabled")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text("We can't notify you when new content is available.")
                        .font(.caption2)
                        .opacity(0.7)
                    
                    Link(destination: URL(string: UIApplication.openSettingsURLString)!, label: {
                        Text("Open Settings")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    })
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
        }
        .onAppear {
            notificationVM.getNotificationSettings()
        }
        .onChange(of: scenePhase, perform: { newPhase in
            print("onChange of scenePhase", newPhase)
            if newPhase == .active {
                notificationVM.getNotificationSettings()
             }
        })

    }
}

struct NotificationsRow_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsRow()
    }
}
