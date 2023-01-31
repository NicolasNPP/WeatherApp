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
 
    func getWeather(success: @escaping (_ weather: WeatherModel) -> (), failure: @escaping (_ error: Error?) -> ()) {
        AF.request("https://api.openweathermap.org/data/2.5/weather?lat=-34.61315&lon=-58.37723&appid=48d90bfb1a4fb9a610f65398727f70b9", method: .get).validate(statusCode: 200...299).responseDecodable (of: WeatherModel.self) { response in
            
            if let weather = response.value{
                success(weather)
            } else {
                failure(response.error)
            }
        }
    }
    
}


