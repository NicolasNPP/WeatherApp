//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Nicolas Pepe on 30/01/2023.
//

import Foundation
import Alamofire
import UIKit

class WeatherService {
    static let shared = WeatherService()
    
    public var weather: WeatherModel?
    private let API_KEY = "48d90bfb1a4fb9a610f65398727f70b9"
    private let UNITS = "&units=metric"
    
    func getWeather(latitude: String, longitude: String, success: @escaping (_ weather: WeatherModel) -> (), failure: @escaping (_ error: Error?) -> ()) {
        AF.request("\(setUrl(lat: latitude, long: longitude, api: "weather"))\(API_KEY)\(UNITS)", method: .get).validate(statusCode: 200...299).responseDecodable (of: WeatherModel.self) { response in
            
            if let weather = response.value{
                success(weather)
            } else {
                failure(response.error)
            }
        }
    }
     
    func getWather5Days(latitude: String, longitude: String, success: @escaping (_ weather: WeetherResponse) -> (), failure: @escaping (_ error: Error?) -> ()) {
        
        AF.request("\(setUrl(lat: latitude, long: longitude, api: "forecast"))\(API_KEY)\(UNITS)", method: .get).validate(statusCode: 200...299).responseDecodable (of: WeetherResponse.self) { response in
            
            if let weather = response.value{
                //print(weather)
                success(weather)
            } else {
                failure(response.error)
            }
        }
    }
            
    private func setUrl(lat: String, long: String, api: String) -> String {
        return "https://api.openweathermap.org/data/2.5/\(api)?lat=\(lat)&lon=\(long)&appid="
    }
    
    
    
    func getIcon(name: String) -> UIImageView{
        var theImg = UIImageView()
        let url = URL(string: "https://openweathermap.org/img/wn/\(name)@2x.png")
        let data = try? Data(contentsOf: url!)
        theImg.image = UIImage(data: data!)
        
        return theImg
    }
}

extension UIImageView {
    func setImage(url: String){
        self.kf.setImage(with: URL(string: url))
        print(url)
    }
}
