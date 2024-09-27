//
//  ContentView.swift
//  WebViewApp
//
//  Created by Mustafa Bekirov on 11.09.2024.
//

import SwiftUI
import AdSupport
import AppTrackingTransparency

struct ContentView: View {
    @StateObject private var webViewManager = WebViewManager()
    @State private var isLoading = true
    
    var body: some View {
        Group {
            if !webViewManager.idfaRequestCompleted {
                LaunchView()
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                        ATTrackingManager.requestTrackingAuthorization { status in
                            switch status {
                            case .authorized:
                                webViewManager.advertisingId = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                                webViewManager.initializeAppsFlyer {
                                    webViewManager.idfaRequestCompleted.toggle()
                                }
                            case .denied, .restricted, .notDetermined:
                                print("Tracking permission not granted")
                            @unknown default:
                                break
                            }
                        }
                    }
            } else {
                WebViewView().environmentObject(webViewManager)
            }
        }
    }
}
