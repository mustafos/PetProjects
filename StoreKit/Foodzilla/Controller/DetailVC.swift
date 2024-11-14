//
//  DetailVC.swift
//  Foodzilla
//
//  Created by Caleb Stultz on 9/14/17.
//  Copyright © 2017 Caleb Stultz. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var itemPriceLbl: UILabel!
    @IBOutlet weak var uglyAdView: UIView!
    @IBOutlet weak var buyItemBtn: UIButton!
    @IBOutlet weak var hideAdsBtn: UIButton!
    
    public private(set) var item: Item!
    private var hiddenStatus: Bool = UserDefaults.standard.bool(forKey: "nonConsumablePurchaseWasMade")
    
    func initData(forItem item: Item) {
        self.item = item
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemImageView.image = item.image
        itemNameLbl.text = item.name
        itemPriceLbl.text = String(describing: item.price)
        buyItemBtn.setTitle("Buy this item for $\(item.price)", for: .normal)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlePurchase(_:)), name: NSNotification.Name(IAPServicePurchaseNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleFailure), name: NSNotification.Name(IAPServiceFailureNotification), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showOrHideAds()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handlePurchase(_ notification: Notification) {
        guard let productID = notification.object as? String else { return }
        
        switch productID {
        case IAP_MEAL_ID:
            buyItemBtn.isEnabled = true
            debugPrint("Meal Successfully Purchased.")
            break
        case IAP_HIDE_ADS_ID:
            uglyAdView.isHidden = true
            hideAdsBtn.isHidden = true
            debugPrint("Ads hidden!")
            break
        default:
            break
        }
    }
    
    @objc func handleFailure() {
        buyItemBtn.isEnabled = true
        debugPrint("Purchase Failed!")
    }
    
    func showOrHideAds() {
        uglyAdView.isHidden = hiddenStatus
        hideAdsBtn.isHidden = hiddenStatus
    }
    
    @IBAction func buyBtnWasPressed(_ sender: Any) {
        buyItemBtn.isEnabled = false
        IAPService.instance.attemptPurchaseForItemWith(productIndex: .meal)
    }
    
    
    @IBAction func hideAdsBtnWasPressed(_ sender: Any) {
        IAPService.instance.attemptPurchaseForItemWith(productIndex: .hideAds)
    }
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
