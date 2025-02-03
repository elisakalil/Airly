//
//  ContentView.swift
//  Airly
//
//  Created by Elisa Kalil on 27/01/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(
                        weather: weather,
                        onRefresh: fetchWeather
                    )
                } else {
                    LoadingView()
                        .task {
                            await fetchWeather()
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(
            Color(
                hue: 0.656,
                saturation: 0.787,
                brightness: 0.354
            )
        )
        .preferredColorScheme(.dark)
    }
    
    func fetchWeather() async {
        guard let location = locationManager.location else { return }
        do {
            weather = try await weatherManager.getCurrentWheather(
                latitude: location.latitude,
                longitude: location.longitude
            )
        } catch {
            print("Error getting weather: \(error)")
        }
    }
}

#Preview {
    ContentView()
}


