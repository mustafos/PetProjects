//
//  LogoView.swift
//  LearnApp
//
//  Created by Mustafa Bekirov on 03.04.2023.
//

import SwiftUI

struct LogoView: View {
    var image = courses[0].logo
    
    var body: some View {
        Image(image)
            .resizable()
            .frame(width: 26, height: 26)
            .cornerRadius(10)
            .padding(8)
            .background(.ultraThinMaterial)
            .backgroundStyle(cornerRadius: 18, opacity: 0.4)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}

