//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Nicolas Pepe on 30/01/2023.
//

import Foundation
import Alamofire

class WeatherService {
    static let shared = WeatherService()
    
    public var weather: WeatherModel?
    private let API_KEY = "48d90bfb1a4fb9a610f65398727f70b9"
    private let UNITS = "&units=metric"
    private func setUrl(lat: String, long: String) -> String {
        return "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid="
    }
    
    func getWeather(latitude: String, longitude: String, success: @escaping (_ weather: WeatherModel) -> (), failure: @escaping (_ error: Error?) -> ()) {
        AF.request("\(setUrl(lat: latitude, long: longitude))\(API_KEY)\(UNITS)", method: .get).validate(statusCode: 200...299).responseDecodable (of: WeatherModel.self) { response in
            
            if let weather = response.value{
                success(weather)
            } else {
                failure(response.error)
            }
        }
    }
    
}


