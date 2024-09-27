//
//  WebViewManager.swift
//  WebViewApp
//
//  Created by Mustafa Bekirov on 12.09.2024.
//

import Foundation
import AppsFlyerLib

class WebViewManager: ObservableObject {
    @Published var advertisingId: String = ""
    @Published var appsflyerId: String = ""
    @Published var conversionData: [String: String] = [:]
    @Published var idfaRequestCompleted: Bool = false
    
    func initializeAppsFlyer(callback: @escaping () -> Void) {
        AppsFlyerLib.shared().appsFlyerDevKey = Config.appsflyerDevKey
        AppsFlyerLib.shared().appleAppID = Config.appId
#if DEBUG
        AppsFlyerLib.shared().isDebug = true
#endif
        
        AppsFlyerLib.shared().start { response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let response = response {
                DispatchQueue.main.async {
                    self.appsflyerId = response["appsflyer_id"] as? String ?? ""
                    self.conversionData = response as? [String: String] ?? [:]
                    print("Appsflyer Data: \(self.conversionData)")
                    callback()
                }
            } else {
                DispatchQueue.main.async {
                    callback()
                }
            }
        }
    }
    
    func createRequestBody(url: String) -> [String: Any] {
        return [
            "url": url,
            "advertisingId": advertisingId,
            "appsflyerId": appsflyerId,
            "conversionData": conversionData,
            "appId": Config.appId
        ]
    }
    
    func openWebViewWithRequest(url: String, requestBody: [String: Any], completion: @escaping (String?) -> Void) {
        guard let serverURL = URL(string: url) else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: serverURL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: [])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data, let responseString = String(data: data, encoding: .utf8) else {
                completion(nil)
                return
            }
            
            print("Server Response: \(responseString)")
            completion(responseString)
        }.resume()
    }
}
