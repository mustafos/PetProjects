//
//  MapView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 05.03.2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 50.073658, longitude: 14.418540),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    
    @State private var mapType: MKMapType = .standard
    var body: some View {
        VStack {
            Picker("", selection: $mapType) {
                Text("Standard").tag(MKMapType.standard)
                Text("Satellite").tag(MKMapType.satellite)
                Text("Hybrid").tag(MKMapType.hybrid)
            }
            .pickerStyle(SegmentedPickerStyle())
            MapsScreenView(region: $region, mapType: mapType, annotation: Annotation(title: "Prague", coordinates: CLLocationCoordinate2D(latitude: 50.073658, longitude: 14.418540)))
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    MapView()
}
