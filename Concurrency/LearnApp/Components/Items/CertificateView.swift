//
//  CertificateView.swift
//  LearnApp
//
//  Created by Mustafa Bekirov on 02.04.2023.
//

import SwiftUI

struct CertificateView: View {
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 8) {
                Text("SwiftUI for iOS 15")
                    .font(.title3.weight(.semibold))
                Text("Certificate")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack(alignment: .leading, spacing: 8) {
                Text("May 21, 2021".uppercased())
                    .font(.footnote.weight(.semibold))
                Text("Designcode instructor: Meng To")
                    .font(.footnote.weight(.medium))
            }
            .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(LogoView().frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing))
        .padding(20)
        .background(.ultraThinMaterial)
        .backgroundStyle(cornerRadius: 30)
    }
}

struct CertificateView_Previews: PreviewProvider {
    static var previews: some View {
        CertificateView()
    }
}

