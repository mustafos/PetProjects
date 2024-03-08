//
//  SegmentEx.swift
//  ProUISwift
//
//  Created by Mustafa Bekirov on 11.05.2023.
//

import SwiftUI

struct SegmentEx: View {
    @State var segmentIndex = 0
    @State var offsetX = 0
    
    var company = ["Nike", "Puma", "Adidas"]
    var sneaker = ["nike", "puma", "adidas"]
    
    var body: some View {
        VStack {
            Text("Sneakers – \(company[segmentIndex])").font(Font.system(.title))
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray)
                    .padding()
                    .offset(x: CGFloat(offsetX))
                Image(sneaker[segmentIndex])
                    .resizable()
                    .frame(width: 300, height: 300)
                    .offset(x: CGFloat(offsetX))
            }.animation(.spring())
            Picker(selection: Binding(get: {
                self.segmentIndex
            }, set: { (newValue) in
                self.segmentIndex = newValue
                self.offsetX = -500
                self.moveBack()
            }), label: Text("")) {
                ForEach(0..<company.count) {
                    Text(self.company[$0]).tag($0)
                }
            }.pickerStyle(SegmentedPickerStyle()).padding()
            Spacer().frame(height: 150)
        }
    }
    
    private func moveBack() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.offsetX = 0
        }
    }
}

struct SegmentEx_Previews: PreviewProvider {
    static var previews: some View {
        SegmentEx()
    }
}
