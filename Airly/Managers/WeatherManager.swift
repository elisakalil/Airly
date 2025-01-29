//
//  WeatherManager.swift
//  Airly
//
//  Created by Elisa Kalil on 27/01/25.
//

import Foundation
import CoreLocation

class WeatherManager {
    func getCurrentWheather(
        latitude: CLLocationDegrees,
        longitude: CLLocationDegrees
    ) async throws -> ResponseBody {
        guard let url = URL(string:"https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=aa3c4c76bc8d8de381e8237ac5113110") else {
            fatalError("Missing URL")
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
}

struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    var sys: SYSResponse
    var timezone: Double
    
    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
    
    struct SYSResponse: Decodable {
        var type: Double
        var id: Double
        var country: String
        var sunrise: Double
        var sunset: Double
    }
}
