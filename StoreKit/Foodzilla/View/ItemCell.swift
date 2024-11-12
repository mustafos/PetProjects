//
//  ItemCell.swift
//  Foodzilla
//
//  Created by Caleb Stultz on 9/14/17.
//  Copyright © 2017 Caleb Stultz. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var itemPriceLbl: UILabel!
    
    func configureCell(forItem item: Item) {
        itemImageView.image = item.image
        itemNameLbl.text = item.name
        itemPriceLbl.text = String(describing: item.price)
    }
}
