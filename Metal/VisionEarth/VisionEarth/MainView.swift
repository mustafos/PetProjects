//
//  MainView.swift
//  LineCraft
//
//  Created by Mustafa Bekirov on 13.01.2025.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    NativeCanvas()
                } label: {
                    Text("Native Canvas")
                }
                NavigationLink {
                    BezierView()
                } label: {
                    Text("Bezier Canvas")
                }
            }
            .navigationTitle("Line Craft")
        }
    }
}

#Preview {
    MainView()
}
