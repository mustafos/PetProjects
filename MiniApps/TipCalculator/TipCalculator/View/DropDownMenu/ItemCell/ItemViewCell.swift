//
//  ItemViewCell.swift
//  TipCalculator
//
//  Created by Mustafa Bekirov on 07.01.2024.
//

import UIKit

class ItemViewCell: UITableViewCell {
    static let identifier = "ItemViewCell"
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
