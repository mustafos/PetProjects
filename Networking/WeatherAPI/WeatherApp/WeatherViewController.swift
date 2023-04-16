//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Mustafa Bekirov on 15.04.2023.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    private let weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.featherWeather(city: "Prague")
    }
    
    @IBAction func addLocationButtonTapped(_ sender: Any) {
    }

    @IBAction func locationButtonTapped(_ sender: Any) {
    }
}

