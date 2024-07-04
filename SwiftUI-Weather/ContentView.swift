//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Umut Yenidil on 3.07.2024.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var isNight = false
    
    @Published var cityName = "Aydin, TR"
    
    func toggleIsNight() {
        isNight.toggle()
    }
}

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        ZStack {
            GradientBackgroundView(
                topColor: viewModel.isNight ? .black : .blue,
                bottomColor: viewModel.isNight ? .gray : Color("lightBlue")
            )
            
            VStack {
                CityTextView(
                    cityName: $viewModel.cityName
                )
                CityStatusView(
                    imageName: viewModel.isNight ? "moon.stars.fill" : "sun.max.fill",
                    temperature: 50
                )
                
                HStack(spacing: 16) {
                    WeatherDayView(
                        dayOfWeek: "TUE",
                        imageName: "cloud.sun.fill",
                        temperature: 12
                    )
                    WeatherDayView(
                        dayOfWeek: "WED",
                        imageName: "sun.max.fill",
                        temperature: 23
                    )
                    WeatherDayView(
                        dayOfWeek: "THU",
                        imageName: "cloud.drizzle.fill",
                        temperature: 34
                    )
                    WeatherDayView(
                        dayOfWeek: "FRI",
                        imageName: "snow",
                        temperature: 45
                    )
                    WeatherDayView(
                        dayOfWeek: "SAT",
                        imageName: "tornado",
                        temperature: 56
                    )
                }
                
                Spacer()
                
                Button {
                    viewModel.toggleIsNight()
                } label: {
                    BottomButton(
                        title: "Change Day",
                        textColor: .blue,
                        backgroundColor: .white
                    )
                }
            
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}

struct WeatherDayView: View {
    let dayOfWeek: String
    let imageName: String
    let temperature: Int
    
    
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(
                    .system(
                        size: 16,
                        weight: .medium
                    )
                )
                .foregroundStyle(.white)
            
            Image(systemName: imageName)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 64, height: 64)
            
            Text("\(temperature)°")
                .font(
                    .system(
                        size: 28,
                        weight: .medium
                    )
                )
                .foregroundStyle(.white)
        }
    }
}

struct GradientBackgroundView: View {
    let topColor: Color
    let bottomColor: Color
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    topColor,
                    bottomColor,
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

struct CityTextView: View {
    @Binding var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(
                .system(
                    size: 32,
                    weight: .medium
                )
            )
            .foregroundStyle(.white)
            .padding()
    }
}

struct CityStatusView: View {
    let imageName: String
    let temperature: Int
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text("\(temperature)°")
                .font(
                    .system(
                        size: 70,
                        weight: .medium
                    )
                )
                .foregroundStyle(.white)
        }.padding(.bottom, 128)
    }
}

struct BottomButton: View {
    let title: String
    let textColor: Color
    let backgroundColor: Color
    
    var body: some View {
        Text(title)
            .frame(width: 280, height: 50)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .font(
                .system(
                    size: 20,
                    weight: .bold
                )
            )
            .cornerRadius(10)
    }
}
