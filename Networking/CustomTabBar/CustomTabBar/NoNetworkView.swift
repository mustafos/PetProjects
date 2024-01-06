//
//  NoNetworkView.swift
//  CustomTabBar
//
//  Created by Mustafa Bekirov on 07.10.2023.
//

import SwiftUI

struct NoNetworkView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "wifi.slash")
                .renderingMode(.template)
                .foregroundColor(.red)
                .layoutPriority(0)
            
            Text("Síťové připojení se zdá být offline.\nZkontrolujte své připojení.")
                .font(.system(.subheadline, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .layoutPriority(1)
        } 
        .padding()
    }
}


#Preview {
    NoNetworkView()
}
