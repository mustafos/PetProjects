//
//  AutoRenewSubView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 31.10.2024.
//

import SwiftUI

//@UIApplicationDelegateAdaptor var delegate: AppDelegate
//import Foundation
//import StoreKit
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        SKPaymentQueue.default().add(IAPService.instance)
//        return true
//    }
//
//    func applicationWillTerminate(_ application: UIApplication) {
//        SKPaymentQueue.default().remove(IAPService.instance)
//    }
//}

struct AutoRenewSubView: View {
    @State private var showSuccessRestoreAlert = false
    @State private var subStatus = ""

    var body: some View {
        VStack {
            Text(subStatus)
            Button {
                IAPService.instance.attemptPurchaseForItemWith(productIndex: .monthly)
            } label: {
                Text("Make Subscription")
            }
        }
        .onAppear {
            IAPService.instance.iapDelegate = self
            IAPService.instance.loadProducts()
            NotificationCenter.default.addObserver(forName: NSNotification.Name(IAPServiceRestoreNotification), object: nil, queue: .main) { notification in
                self.handleRestore()
            }
            NotificationCenter.default.addObserver(forName: NSNotification.Name(IAPSubInfoChangedNotification), object: nil, queue: .main) { notification in
                self.subscriptionStatusWasChange(notification)
            }
            IAPService.instance.isSubscriptionActive { active in }
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self)
        }
        .alert("Success!", isPresented: $showSuccessRestoreAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Your purchases were successfully restored.")
        }
    }

    func handleRestore() {
        showSuccessRestoreAlert.toggle()
        debugPrint("Restore purchase successful.")
    }

    func subscriptionStatusWasChange(_ notification: Notification) {
        guard let status = notification.object as? Bool else { return }
        DispatchQueue.main.async {
            if status == true {
                debugPrint("Subscription valid")
                self.subStatus = "SUBSCRIPTION ACTIVE"
            } else {
                debugPrint("Subscription expired")
                subStatus = "SUBSCRIPTION EXPIRED"
            }
        }
    }
}

// MARK: - IAPServiceDelegate
extension AutoRenewSubView: IAPServiceDelegate {
    func iapProductsLoaded() {
        print("IAP PRODUCTS LOADED")
    }
}

#Preview {
    AutoRenewSubView()
}

// MARK: Product
import Foundation

enum Product: Int {
    case weekly = 0
    case monthly = 1
    case yearly = 2
}

// MARK: Purchase Status
import Foundation

enum PurchaseStatus {
    case purchased
    case restored
    case failed
    case subscribed
}

// MARK: – Notification Identifier
let IAPServicePurchaseNotification = "IAPServicePurchaseNotification"
let IAPServiceRestoreNotification = "IAPServiceRestoreNotification"
let IAPServiceFailureNotification = "IAPServiceFailureNotification"
let IAPSubInfoChangedNotification = "IAPSubInfoChangedNotification"

import SwiftUI
import StoreKit

protocol IAPServiceDelegate {
    func iapProductsLoaded()
}

class IAPService: SKReceiptRefreshRequest, SKProductsRequestDelegate {
    static let instance = IAPService()

    var iapDelegate: IAPServiceDelegate?

    var products = [SKProduct]()
    var productIds = Set<String>()
    var productRequest = SKProductsRequest()

    var expirationDate = UserDefaults.standard.value(forKey: "expirationDate") as? Date
    var nonConsumablePurchaseWasMade = UserDefaults.standard.bool(forKey: "nonConsumablePurchaseWasMade")

    func loadProducts() {
        productIdToStringSet()
        requestProducts(forIds: productIds)
    }

    func productIdToStringSet() {
        let ids = ["proplus_weekly", "proplus_monthly", "proplus_yearly"]
        for id in ids {
            productIds.insert(id)
        }
    }

    func requestProducts(forIds ids: Set<String>) {
        productRequest.cancel()
        productRequest = SKProductsRequest(productIdentifiers: ids)
        productRequest.delegate = self
        productRequest.start()
    }

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products

        if products.count == 0 {
            requestProducts(forIds: productIds)
        } else {
            iapDelegate?.iapProductsLoaded()
            print(products[0].localizedTitle)
        }
    }

    func attemptPurchaseForItemWith(productIndex: Product) {
        let product = products[productIndex.rawValue]
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }

    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }

    func requestDidFinish(_ request: SKRequest) {
        uploadReceipt { valid in
            if valid {
                // check to see if subscription is still active
                debugPrint("SUBSCRIPTION VALID")
                self.isSubscriptionActive { active in
                    if active {
                        debugPrint("SUBSCRIPTION ACTIVE")
                        self.sendNotificationFor(status: .subscribed, withIdentifier: nil, orBoolean: true)
                        self.setNonConsumablePurchase(true)
                    } else {
                        debugPrint("SUBSCRIPTION EXPIRED")
                        self.sendNotificationFor(status: .subscribed, withIdentifier: nil, orBoolean: false)
                        self.setNonConsumablePurchase(false)
                    }
                }
            } else {
                // lock out the subscription benefits
                debugPrint("SUBSCRIPTION INVALID")
                self.sendNotificationFor(status: .subscribed, withIdentifier: nil, orBoolean: false)
                self.setNonConsumablePurchase(false)
            }
        }
    }

    func isSubscriptionActive(completionHandler: @escaping (Bool) -> Void) {
        reloadExpiryDate()
        let nowDate = Date()
        debugPrint("TIME REMAINING: ", (expirationDate?.timeIntervalSinceNow)! / 60, "MINUTES")
        guard let expirationDate = expirationDate else { return }
        if nowDate.isLessThen(expirationDate) {
            completionHandler(true)
        } else {
            completionHandler(false)
        }
    }

    func uploadReceipt(completionHandler: @escaping (Bool) -> Void) {
        guard let receiptUrl = Bundle.main.appStoreReceiptURL, let receipt = try? Data(contentsOf: receiptUrl).base64EncodedString() else {
            debugPrint("No receipt url")
            completionHandler(false)
            return
        }

        let body = [
            "receipt-data": receipt,
            // TODO: – add shared secret from app store connect
            "password": "shared secret"
        ]

        let bodyData = try! JSONSerialization.data(withJSONObject: body, options: [])

        let url = URL(string: "https://sandbox.itunes.apple.com/verifyReceipt")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = bodyData

        let task = URLSession.shared.dataTask(with: request) { responseData, response, error in
            if let error = error {
                debugPrint("ERROR: ", error)
                completionHandler(false)
            } else if let responseData = responseData {
                let json = try! JSONSerialization.jsonObject(with: responseData, options: []) as! Dictionary<String, Any>
                let newExpirationDate = self.expirationDataFromResponse(jsonResponse: json)
                self.setExpiration(forDate: newExpirationDate!)
                debugPrint("NEW EXPIRATION DATE: ", newExpirationDate!)
                completionHandler(true)
            }
        }
        task.resume()
    }

    func expirationDataFromResponse(jsonResponse: Dictionary<String, Any>) -> Date? {
        if let receiptInfo: NSArray = jsonResponse["latest_receipt_info"] as? NSArray {
            let lastReceipt = receiptInfo.lastObject as? Dictionary<String, Any>
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss VV"
            let expirationDate: Date = (formatter.date(from: lastReceipt!["expires_date"] as! String) as Date?)!
            return expirationDate
        } else {
            return nil
        }
    }

    func setExpiration(forDate date: Date) {
        UserDefaults.standard.set(date, forKey: "expirationDate")
    }

    func reloadExpiryDate() {
        expirationDate = UserDefaults.standard.value(forKey: "expirationDate") as? Date
    }
}

extension IAPService: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                complete(transaction: transaction)
                SKPaymentQueue.default().finishTransaction(transaction)
                debugPrint("Purchase was successful!")
            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                break
            case .failed:
                sendNotificationFor(status: .failed, withIdentifier: nil, orBoolean: nil)
                SKPaymentQueue.default().finishTransaction(transaction)
                break
            case .deferred:
                SKPaymentQueue.default().finishTransaction(transaction)
                break
            case .purchasing:
                debugPrint("Purchasing...")
                break
            @unknown default:
                fatalError()
            }
        }
    }

    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        sendNotificationFor(status: .restored, withIdentifier: nil, orBoolean: nil)
        setNonConsumablePurchase(true)
    }

    func complete(transaction: SKPaymentTransaction) {
        switch transaction.payment.productIdentifier {
        case "proplus_weekly":
            self.sendNotificationFor(status: .subscribed, withIdentifier: nil, orBoolean: true)
            self.setNonConsumablePurchase(true)
            break
        case "proplus_monthly":
            self.sendNotificationFor(status: .subscribed, withIdentifier: nil, orBoolean: true)
            self.setNonConsumablePurchase(true)
            break
        case "proplus_yearly":
            self.sendNotificationFor(status: .subscribed, withIdentifier: nil, orBoolean: true)
            self.setNonConsumablePurchase(true)
            break
        default:
            break
        }
    }

    func setNonConsumablePurchase(_ status: Bool) {
        UserDefaults.standard.set(status, forKey: "nonConsumablePurchaseWasMade")
    }

    func sendNotificationFor(status: PurchaseStatus, withIdentifier identifier: String?, orBoolean bool: Bool?) {
        switch status {
        case .purchased:
            NotificationCenter.default.post(name: NSNotification.Name(IAPServicePurchaseNotification), object: identifier)
            break
        case .restored:
            NotificationCenter.default.post(name: NSNotification.Name(IAPServiceRestoreNotification), object: nil)
            break
        case .failed:
            NotificationCenter.default.post(name: NSNotification.Name(IAPServiceFailureNotification), object: nil)
            break
        case .subscribed:
            NotificationCenter.default.post(name: NSNotification.Name(IAPSubInfoChangedNotification), object: bool)
            break
        }
    }
}
