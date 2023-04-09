//
//  DetailViewController.swift
//  ToDoApp
//
//  Created by Mustafa Bekirov on 09.04.2023.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var locationLabel: UILabel!
    
    var task: Task!
    var dateFormatter: DateFormatter {
        let df = DateFormatter()
            df.dateFormat = "MMM d, yyyy"
            return df
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.titleLabel.text = task.title
        self.descriptionLabel.text = task.description
        self.locationLabel.text = task.location?.name
        self.dateLabel.text = dateFormatter.string(from: task.date)
        
        if let coordinate = task.location?.coordinate {
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
            mapView.region = region
        }
    }
}
