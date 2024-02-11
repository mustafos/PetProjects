//
//  LocationView.swift
//  MapsApp
//
//  Created by Mustafa Bekirov on 15.09.2023.
//

import SwiftUI
import MapKit

struct LocationView: View {
    @StateObject private var viewModel = LocationViewModel()
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .ignoresSafeArea()
            .accentColor(Color(.systemCyan))
            .onAppear {
                viewModel.checkIfLocationServiceIsEnabled()
            }
    }
}

#Preview {
    LocationView()
}
