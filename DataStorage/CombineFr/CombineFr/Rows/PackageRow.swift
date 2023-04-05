//
//  PackageRow.swift
//  CombineFr
//
//  Created by Mustafa Bekirov on 05.04.2023.
//

import SwiftUI

struct PackageRow: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var package: Package
    
    var body: some View {
        VStack(alignment: .leading) {
            Link(destination: URL(string: package.link)!, label: {
                LinearGradient(gradient: Gradient(colors: colorScheme == .dark ? [Color(#colorLiteral(red: 0.6196078431, green: 0.6784313725, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.5607843137, blue: 0.9803921569, alpha: 1))] : [Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(height: 20)
                    .mask(Text(package.title)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .textCase(.uppercase)
                        .frame(maxWidth: .infinity,
                               alignment: .leading)
                    )
            })
            
            Divider()
        }
    }
}

struct PackageRow_Previews: PreviewProvider {
    static var previews: some View {
        PackageRow(package: packagesData[0])
            .environment(\.colorScheme, .dark)
    }
}
