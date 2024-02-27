//
//  MenuExample.swift
//  TipCalculator
//
//  Created by Mustafa Bekirov on 10.01.2024.
//

import UIKit

class MenuExample: UIViewController {
    
    @IBOutlet weak var containerStackView: UIStackView!
    
    @IBOutlet weak var selectItemView: UIView!
    @IBOutlet weak var selectedText: UILabel!
    @IBOutlet weak var selectImage: UIImageView!
    
    
    @IBOutlet var colorButtons: [UIButton]!
    
    @IBOutlet weak var colorView: UIView!
    
    private var isHideButtons: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSelectButtonImage()
        containerStackView.spacing = 1
        containerStackView.layer.borderColor = UIColor(.black).cgColor
        containerStackView.layer.borderWidth = 1
        containerStackView.layer.cornerRadius = selectItemView.frame.height / 2
        containerStackView.backgroundColor = .gray
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectedColorAction(_:)))
        selectItemView.addGestureRecognizer(tapGesture)
    }
    
    func showButtonVisibility() {
        colorButtons.forEach { button in
            UIView.animate(withDuration: 0.3) {
                self.isHideButtons.toggle()
                button.isHidden.toggle()
                self.updateSelectButtonImage()
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func selectedColorAction(_ sender: Any) {
        showButtonVisibility()
    }
    
    @IBAction func colorButtonAction(_ sender: UIButton) {
        showButtonVisibility()
        switch sender.currentTitle {
        case "Green":
            setButtonProperties(backgroundColor: .green, title: "Green", image: "chevron.down")
            colorView.backgroundColor = .green
        case "Red":
            setButtonProperties(backgroundColor: .red, title: "Red", image: "chevron.down")
            colorView.backgroundColor = .red
        case "Indigo":
            setButtonProperties(backgroundColor: .systemIndigo, title: "Indigo", image: "chevron.down")
            colorView.backgroundColor = .systemIndigo
        default:
            setButtonProperties(backgroundColor: .gray, title: "Default", image: "chevron.down")
            colorView.backgroundColor = .gray
        }
    }
    
    private func setButtonProperties(backgroundColor: UIColor, title: String, image: String) {
        selectItemView.backgroundColor = .clear
        selectedText.text = title
        selectedText.textColor = backgroundColor
        selectImage.image = UIImage(systemName: image)
    }
    
    private func updateSelectButtonImage() {
        let imageName = isHideButtons ? "chevron.down" : "chevron.up"
        selectImage.image = UIImage(systemName: imageName)
    }
}
