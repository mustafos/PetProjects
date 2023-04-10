//
//  Location.swift
//  ToDoApp
//
//  Created by Mustafa Bekirov on 08.04.2023.
//

import Foundation
import CoreLocation

struct Location {
    let name: String
    let coordinate: CLLocationCoordinate2D?
    
    init(name: String, coordinate: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
}

extension Location {
    typealias PlistDictionary = [String : Any]
    init?(dict: PlistDictionary) {
        self.name = dict["name"] as! String
        if let latitude = dict["latitude"] as? Double,
           let longitude = dict["longitude"] as? Double {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = nil
        }
    }
}

extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        guard rhs.coordinate?.latitude == lhs.coordinate?.latitude &&
        lhs.coordinate?.longitude == rhs.coordinate?.longitude &&
            lhs.name == rhs.name else { return false }
        return true
    }
}
