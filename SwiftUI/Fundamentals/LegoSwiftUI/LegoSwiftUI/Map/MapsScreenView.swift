//
//  MapsScreenView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 05.03.2024.
//

import SwiftUI
import MapKit

struct MapsScreenView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    let mapType: MKMapType
    let annotation: Annotation
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.setRegion(region, animated: false)
        mapView.mapType = mapType
        mapView.delegate = context.coordinator
        mapView.addAnnotation(annotation.pointAnnotation)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.mapType = mapType
        uiView.setRegion(region, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapsScreenView
        
        init(parent: MapsScreenView) {
            self.parent = parent
        }

        func mapView(mapView: MKMapView, annotation: MKAnnotation) -> MKAnnotationView? {
            guard annotation is MKPointAnnotation else { return nil }
            let identifier = "Annotation"
            guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) else {
                let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView.canShowCallout = true
                return annotationView
            }
            annotationView.annotation = annotation
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            DispatchQueue.main.async {
                self.parent.region = mapView.region
            }
        }
    }
}
