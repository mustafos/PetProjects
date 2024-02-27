//
//  DetailViewController.swift
//  Proxy
//
//  Created by Mustafa Bekirov on 17.02.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let url = URL(string: "http://4.bp.blogspot.com/-UgXwdGMcpNI/UR5OTH9WrzI/AAAAAAAACEI/nUN5v2JtRyQ/s1600/Volkswagen_Logo.png")!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImage()
    }
    
    func loadImage() {
        let imageService = LoadImageService()
        let proxy = Proxy(service: imageService)
        
        proxy.loadImage(url: url) { [weak self] (data, response, error) in
            guard let self = self, let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        cacheData = nil
        imageView.image = nil
        loadImage()
    }
}
