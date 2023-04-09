//
//  ViewController.swift
//  Geocoder
//
//  Created by Mustafa Bekirov on 09.04.2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString("Pilsen") { (placemarks, error) in
            let placemarks = placemarks?.first
            
            let latitude = placemarks?.location?.coordinate.latitude
            let longitude = placemarks?.location?.coordinate.longitude
            
            print(latitude, longitude)
        }
    }


}

