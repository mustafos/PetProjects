//
//  Annotation.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 05.03.2024.
//

import MapKit

struct Annotation {
    let pointAnnotation: MKPointAnnotation
    
    init(title: String, coordinates: CLLocationCoordinate2D) {
        pointAnnotation = MKPointAnnotation()
        pointAnnotation.title = title
        pointAnnotation.coordinate = coordinates
    }
}
