//
//  SliderViewController.swift
//  TipCalculator
//
//  Created by Mustafa Bekirov on 14.01.2024.
//

import UIKit

class SliderViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    private var imageView = UIImageView()
    private var size: CGFloat = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.backgroundColor = .systemBlue
        imageView.frame = CGRect(x: 0, y: 0,
                                 width: size,
                                 height: size - 100)
        imageView.center = view.center
        self.view.addSubview(imageView)
    }

    @IBAction func sliderDidSlide(_ sender: UISlider) {
        let value = sender.value
        
        label.text = "\(value)"

        imageView.frame = CGRect(x: 0, y: 0,
                                 width: size * CGFloat(value),
                                 height: size * CGFloat(value) - 100)
        imageView.center = view.center
    }
}
