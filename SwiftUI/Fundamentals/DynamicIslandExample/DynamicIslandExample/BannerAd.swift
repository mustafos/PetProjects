//
//  BannerAd.swift
//  DynamicIslandExample
//
//  Created by Mustafa Bekirov on 21.03.2024.
//
//ca-app-pub-4744463005672993~9800471344
//ca-app-pub-4744463005672993/8422976347
import SwiftUI
import GoogleMobileAds

struct BannerAd: UIViewRepresentable {
    var unitID: String
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> GADBannerView {
        let adView = GADBannerView(adSize: GADAdSizeBanner)
        adView.adUnitID = unitID
        adView.rootViewController = UIApplication.shared.getRootViewController()
        adView.delegate = context.coordinator
        adView.load(GADRequest())
        return adView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    class Coordinator: NSObject, GADBannerViewDelegate {
        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
            print("bannerViewDidReceiveAd")
        }
        
        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: any Error) {
            print("bannerView: didFailToReceiveAdWithError: \(error.localizedDescription)")
        }
        
        func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
            print("bannerViewDidRecordImpression")
        }
        
        func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
            print("bannerViewWillPresentScreen")
        }
        
        func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
            print("bannerViewWillDismissScreen")
        }
        
        func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
            print("bannerViewDidDismissScreen")
        }
    }
}

extension UIApplication {
    func getRootViewController() -> UIViewController {
        guard let screen = self.connectedScenes.first as? UIWindowScene else { return .init() }
        guard let root = screen.windows.first?.rootViewController else { return .init() }
        return root
    }
}
