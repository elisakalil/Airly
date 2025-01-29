//
//  WeatherView.swift
//  Airly
//
//  Created by Elisa Kalil on 28/01/25.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Header(with: weather)
                Spacer()
                Spacer()
                CardView(with: weather)
                Spacer()
            }
            .padding()
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            CardInfo(with: weather)
        }
        .edgesIgnoringSafeArea(.bottom)
        .preferredColorScheme(.dark)
        .background(
            Color(
                hue: 0.656,
                saturation: 0.787,
                brightness: 0.354
            )
        )
    }
}

@ViewBuilder
func Header(with weather: ResponseBody) -> some View {
    let value = weather.main.feels_like.roundDouble()
    let formattedValue = value.formattedTemperature(locale: Locale(identifier: "pt-BR"))
    
    VStack(alignment: .leading, spacing: 5) {
        Text(weather.name)
            .bold().font(.title)
        
        Text("Today \(Date().formatted(.dateTime.month().day().hour().minute()))")
            .fontWeight(.light)
        
        HStack {
            VStack(spacing: 10) {
                Image(systemName: "aqi.medium")
                    .font(.system(size: 40))
                Text(weather.weather[0].main)
            }
            .frame(width: 150, alignment: .leading)
            
            Spacer()
            
            Text(formattedValue + "°")
                .font(.system(size: 80))
                .fontWeight(.bold)
                .padding()
        }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
}

@ViewBuilder
func CardView( with weather: ResponseBody) -> some View {
    var sunriseTime: String {
        let date = Date(timeIntervalSince1970: weather.sys.sunrise)
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone.current
        return formatter.string(from: date)
    }
    
    var sunsetTime: String {
        let date = Date(timeIntervalSince1970: weather.sys.sunset)
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone.current
        return formatter.string(from: date)
    }
    
    var timezoneString: String {
        let hours = weather.timezone / 3600
        return "UTC \(hours >= 0 ? "+" : "")\(hours)"
    }
    
    Spacer()
    
    GeometryReader { geometry in
        VStack(
            alignment: .leading,
            spacing: 20
        ) {
            VStack(alignment: .leading) {
                HStack {
                    Text(
                        Locale.current.localizedString(
                            forRegionCode: weather.sys.country
                        ) ?? weather.sys.country
                    )
                    .bold()
                    .font(.system(.title))
                }
                
                Text("Timezone: \(timezoneString)")
                    .font(.system(.caption))
            }
            .padding(.bottom)
            
            HStack(spacing: 20) {
                Image(systemName: "sunrise")
                    .font(.title2)
                    .frame(
                        width: 20,
                        height: 20
                    )
                    .padding()
                    .background(
                        Color(
                            hue: 1.0,
                            saturation: 0.0,
                            brightness: 0.888
                        )
                    )
                    .cornerRadius(50)
                
                Spacer()
                
                VStack(
                    alignment: .trailing,
                    spacing: 8
                ) {
                    Text("Sunrise")
                        .font(.caption)
                    Text(sunriseTime)
                        .bold()
                        .font(.title)
                }
            }
            
            HStack(spacing: 20) {
                Image(systemName: "sunset.fill")
                    .font(.title2)
                    .frame(
                        width: 20,
                        height: 20
                    )
                    .padding()
                    .background(
                        Color(
                            hue: 1.0,
                            saturation: 0.0,
                            brightness: 0.888
                        )
                    )
                    .cornerRadius(50)
                
                Spacer()
                
                VStack(
                    alignment: .trailing,
                    spacing: 8
                ) {
                    Text("Sunset")
                        .font(.caption)
                    Text(sunsetTime)
                        .bold()
                        .font(.title)
                }
            }
        }
        .padding()
        .padding(.bottom, 20)
        .frame(width: geometry.size.width - 2)
        .foregroundColor(
            Color(
                hue: 0.656,
                saturation: 0.787,
                brightness: 0.354
            )
        )
        .background(.white.opacity(0.45))
        .cornerRadius(
            20,
            corners: [.topRight, .topLeft, .bottomLeft, .bottomRight]
        )
    }
}

@ViewBuilder
func CardInfo(with weather: ResponseBody) -> some View {
    VStack {
        Text("Weather now")
            .bold().padding(.bottom)
        HStack(
            spacing: 20
        ) {
            VStack {
                WeatherRow(
                    logo: "thermometer",
                    name: "Min temp",
                    value: weather.main.temp_min.roundDouble() + "°"
                )
                
                
                WeatherRow(
                    logo: "thermometer",
                    name: "Max temp",
                    value: weather.main.temp_max.roundDouble() + "°"
                )
            }

            VStack {
                WeatherRow(
                    logo: "wind",
                    name: "Wind speed",
                    value: weather.wind.speed.roundDouble() + "m/s"
                )
                                
                WeatherRow(
                    logo: "humidity",
                    name: "Humidity",
                    value: weather.main.humidity.roundDouble() + "%"
                )
            }
        }
        .padding(.bottom, 20)
        
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding()
    .foregroundColor(
        Color(
            hue: 0.656,
            saturation: 0.787,
            brightness: 0.354
        )
    )
    .background(.white)
    .cornerRadius(
        20,
        corners: [.topRight, .topLeft]
    )
}

#Preview {
    WeatherView(weather: previewWeather)
}
