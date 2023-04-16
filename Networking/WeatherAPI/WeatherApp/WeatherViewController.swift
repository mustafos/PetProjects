//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Mustafa Bekirov on 15.04.2023.
//

import UIKit
import SkeletonView

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    private let weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAnimation()
        fetchWeather()
    }
    
    private func fetchWeather() {
        weatherManager.fetchWeather(byCity: "Prague") { [weak self] (result) in
            guard let this = self else { return }
            switch result {
                case .success(let weatherData):
                    this.updateView(with: weatherData)
                case .failure(let error):
                    print("error here: \(error.localizedDescription)")
            }
        }
    }
    
    private func updateView(with data: WeatherData) {
        hideAnimation()
        temperatureLabel.text = data.main.temp.toString().appending("°C")
        conditionLabel.text = data.weather.first?.description
        navigationItem.title = data.name
    }
    
    private func hideAnimation() {
        conditionImageView.hideSkeleton()
        temperatureLabel.hideSkeleton()
        conditionLabel.hideSkeleton()
    }
    
    private func showAnimation() {
        conditionImageView.showAnimatedGradientSkeleton()
        temperatureLabel.showAnimatedGradientSkeleton()
        conditionLabel.showAnimatedGradientSkeleton()
    }
    
    @IBAction func addLocationButtonTapped(_ sender: Any) {
    }

    @IBAction func locationButtonTapped(_ sender: Any) {
    }
}

