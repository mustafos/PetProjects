//
//  ContentView.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 26.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isNight = false
    @State private var isVideoPlayerPresented = false
    var body: some View {
        ZStack {
            BackgroungView(isNight: $isNight)
            VStack {
                HStack {
                    Spacer()
                    Button("VideoPlayer", systemImage: "play.circle") {
                        isVideoPlayerPresented.toggle()
                    }
                    .fullScreenCover(isPresented: $isVideoPlayerPresented) {
                        MainVideoView()
                    }
                }
                .padding()
                
                CityTextView(cityName: "Prague, CZ")
                
                MainWeatherView(imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill", temperature: 14)
                
                HStack(spacing: 20) {
                    WeatherDayView(dayOfWeek: "tue", imageName: "sun.max.fill", temperature: 18)
                    WeatherDayView(dayOfWeek: "wed", imageName: "cloud.snow.fill", temperature: 2)
                    WeatherDayView(dayOfWeek: "thu", imageName: "wind.snow", temperature: 12)
                    WeatherDayView(dayOfWeek: "fri", imageName: "cloud.rain.fill", temperature: 13)
                    WeatherDayView(dayOfWeek: "sat", imageName: "snowflake", temperature: -2)
                }
                Spacer()
                
                Button(action: {
                    isNight.toggle()
                }, label: {
                    WeatherButton(title: "Change Day Time", textColor: .white, backgroundColor: Color.cyan)
                })
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}

struct WeatherDayView: View {
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(dayOfWeek.uppercased())
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(.white)
            
            Image(systemName: imageName)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("\(temperature)°")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct BackgroungView: View {
    @Binding var isNight: Bool
    var body: some View {
        //        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .lemon, isNight ? .gray : .sky]), startPoint: .topTrailing, endPoint: .bottomLeading)
        //            .ignoresSafeArea()
        ContainerRelativeShape()
            .fill(isNight ? Color.black.gradient : Color.red.gradient)
            .ignoresSafeArea()
    }
}

struct CityTextView: View {
    var cityName: String
    var body: some View {
        Text(cityName)
            .font(.system(.largeTitle, design: .rounded))
            .foregroundColor(.white)
            .padding()
    }
}

struct MainWeatherView: View {
    var imageName: String
    var temperature: Int
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text("\(temperature)°")//com shift 8
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}
