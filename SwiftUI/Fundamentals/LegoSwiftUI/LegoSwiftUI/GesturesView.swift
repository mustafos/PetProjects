//
//  GesturesView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 25.03.2024.
//

import SwiftUI

struct GesturesView: View {
    var body: some View {
        VStack {
            HStack {
                Text("TapGestures")
                Spacer()
                TapGesturesView()
            }
            HStack {
                Text("LongTapGestures")
                Spacer()
                LongTapGesturesView()
            }
            HStack {
                Text("DragGestures")
                Spacer()
                DragGesturesView()
            }
            HStack {
                Text("RotationGestures")
                Spacer()
                RotationGesturesView()
            }
        }
        .padding()
    }
}

#Preview {
    GesturesView()
}

struct TapGesturesView: View {
    @State private var changeColor = Color.red
    var body: some View {
        VStack {
            let tapGesture = TapGesture().onEnded { _ in
                if self.changeColor == .red {
                    withAnimation {
                        self.changeColor = .gray
                    }
                } else if self.changeColor == .gray {
                    withAnimation {
                        self.changeColor = .red
                    }
                }
            }
            Circle()
                .foregroundStyle(changeColor)
                .shadow(radius: 10)
                .gesture(tapGesture)
                .frame(width: 100)
        }
    }
}

struct LongTapGesturesView: View {
    
    @State private var didLongPress: Bool = false
    @State private var scale: CGFloat = 1
    @State private var color = Color.yellow
    
    var body: some View {
        VStack {
            Circle()
                .scaleEffect(scale)
                .frame(width: 100)
                .foregroundStyle(color)
                .gesture(
                    LongPressGesture()
                        .onEnded({ _ in
                            if self.didLongPress == false {
                                withAnimation {
                                    self.scale = 1.2
                                    self.color = .gray
                                }
                            } else if self.didLongPress == true {
                                withAnimation {
                                    self.scale = 1
                                    self.color = .yellow
                                }
                            }
                            self.didLongPress.toggle()
                        })
                )
        }
    }
}

struct DragGesturesView: View {
    @State private var drag: CGSize = .zero
    @State private var color = Color.green
    var body: some View {
        VStack {
            Circle()
                .frame(width: 100)
                .foregroundStyle(color)
                .shadow(radius: 10)
                .offset(drag)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation {
                                self.drag = value.translation
                            }
                        })
                        .onEnded({ _ in
                            withAnimation {
                                self.drag = .zero
                            }
                        })
                )
        }
    }
}

struct RotationGesturesView: View {
    @State private var rotation: Angle = .zero
    @State private var color = Color.blue
    var body: some View {
        VStack {
            Rectangle()
                .foregroundStyle(color)
                .cornerRadius(10)
                .shadow(radius: 10)
                .rotationEffect(rotation)
                .frame(width: 100, height: 100)
                .gesture(
                    RotationGesture()
                        .onChanged({ value in
                            withAnimation {
                                self.rotation = value
                            }
                        })
                )
        }
    }
}
