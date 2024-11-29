//
//  MaskImageTemplate.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 07.12.2024.
//

import SwiftUI

struct MaskImageTemplate: View {
    var body: some View {
        OnBoarding()
    }
}

#Preview {
    MaskImageTemplate()
}

struct OnBoarding: View {
    let rotationAngles: [Double] = [0, 90, -90, -180]
    let offsets: [Double] = [0, 50, 0, 50]
    let images: [String] = ["1", "2", "3", "4"]
    var body: some View {
        VStack(spacing: 25) {
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(155)), count: 2), spacing: 13) {
                ForEach(0..<4, id: \.self) { items in
                    ZStack {
                        Rectangle().fill(.gray.opacity(0.3)).frame(width: 150, height: 150)
                        Image(images[items]).resizable().frame(width: 150, height: 150)
                    }
                    .mask {
                        ZStack {
                            Circle()
                                .fill(.red)
                                .frame(width: 150, height: 150)
                            
                            Rectangle()
                                .fill(.red)
                                .frame(width: 80, height: 80)
                                .offset(x: 35, y: 35)
                        }
                        .rotationEffect(.degrees(rotationAngles[items]))
                    }
                    .offset(y: offsets[items])
                }
            }.padding(.bottom, 50)
            
            Text("Find and Match \n what you expect").font(.custom("Rubik-Medium", size: 35)).multilineTextAlignment(.center)
            
            Text("Lorem Ipsum, cursus eu justo et, commodo malesuada lacus. Donec at felis eleifend, commodo urna quis, aliquam lectus. Nulla facilisi.").font(.custom("Rubik-light", size: 16)).multilineTextAlignment(.center).foregroundStyle(.gray)
            
            Button {
                HapticFeedback.playSelection()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.pink.opacity(0.5))
                        .frame(height: 65)
                    
                    Text("Get Started").font(.custom("Rubik-Medium", size: 25)).foregroundStyle(.white)
                }
            }.padding(.top).buttonStyle(.plain)
            
        }.padding(.horizontal)
    }
}

import SwiftUI

class HapticFeedback {
    ///MARK: USE
    ///HapticFeedback.playSelection()
    
    #if os(watchOS)
    //watchOS implementation
    static func playSelection() -> Void {
        WKInterfaceDevice.current().play(.click)
    }
    #elseif os(iOS)
    //iOS implementation
    let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    static func playSelection() -> Void {
        UISelectionFeedbackGenerator().selectionChanged()
    }
    #else
    static func playSelection() -> Void {
        //No-op
    }
    #endif
}
