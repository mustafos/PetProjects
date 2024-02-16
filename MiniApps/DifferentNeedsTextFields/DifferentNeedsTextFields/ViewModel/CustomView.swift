//
//  CustomView.swift
//  DifferentNeedsTextFields
//
//  Created by Mustafa Bekirov on 14.05.2023.
//

import UIKit

class CustomView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    struct ViewModel {
        let nameTF: String
        let placNameTF: String
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 60)
    }
    
    private func commonInit() {
        let bundle = Bundle(for: CustomView.self)
        bundle.loadNibNamed("CustomView", owner: self, options: nil)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        // Set accessibility identifiers
        nameLabel.accessibilityIdentifier = "customViewNameLabel"
        inputTextField.accessibilityIdentifier = "customViewInputTextField"
    }
    
    func configure(viewModel: ViewModel) {
        nameLabel.text = viewModel.nameTF
        inputTextField.placeholder = viewModel.placNameTF
    }
}
