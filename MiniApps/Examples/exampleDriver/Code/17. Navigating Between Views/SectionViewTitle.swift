//
//  SectionViewTitle.swift
//  SwiftUIConcurrencyFinal
//
//  Created by Stephanie Diep on 2021-06-22.
//

import SwiftUI

struct SectionViewTitle: View {
    var section: SectionsCollection.Section
    
    var body: some View {
        Text(section.title)
            .font(.largeTitle)
            .bold()
            .foregroundColor(.white)
            .frame(maxWidth: 300, alignment: .leading)
            .padding(.horizontal, 20)
            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.25), radius: 40, x: 0, y: 10)
            .fixedSize(horizontal: false, vertical: true)
    }
}

struct SectionViewTitle_Previews: PreviewProvider {
    static var previews: some View {
        SectionViewTitle(section: (coursePreviewData.sectionCollection?.sections.first)!)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.init(hex: coursePreviewData.colors.first!!))
    }
}
