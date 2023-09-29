//
//  SectionRow.swift
//  SwiftUIConcurrencyFinal
//
//  Created by Stephanie Diep on 2021-06-22.
//

import SwiftUI

struct SectionRow: View {
    var section: SectionsCollection.Section
    var index: Int
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                Circle()
                    .strokeBorder(Color.primary.opacity(0.1), lineWidth: 1)
                    .background(Circle().foregroundColor(Color(.white).opacity(0.8)))

                Text("\(index)")
                    .foregroundColor(.primary)

            }
            .frame(width: 36, height: 36)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(section.title)
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(Color.primary)
                
                
                Text(section.subtitle)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                Divider().padding(.bottom, 12)
            }
        }
        
    }
}

struct SectionRow_Previews: PreviewProvider {
    static var previews: some View {
        SectionRow(section: (coursePreviewData.sectionCollection?.sections[0])!, index: 1)
    }
}
