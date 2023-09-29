//
//  ActivityViewEx.swift
//  ProUISwift
//
//  Created by Mustafa Bekirov on 11.05.2023.
//

import SwiftUI

struct ActivityViewEx: View {
    @State private var isSharePresented = false
    
    var body: some View {
        Button("press") {
            self.isSharePresented = true
        }.sheet(isPresented: $isSharePresented) {
            ActivityView(activityItems: ["message test"])
        }
    }
}

struct ActivityViewEx_Previews: PreviewProvider {
    static var previews: some View {
        ActivityViewEx()
    }
}
