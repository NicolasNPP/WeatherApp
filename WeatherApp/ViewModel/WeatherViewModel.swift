//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Nicolas Pepe on 30/01/2023.
//

import Foundation
import Combine
import Alamofire

class WeatherViewModel {
    @Published var weatherList: WeatherModel?
    //Creo subject para que se suscriban
    
    func getWeather(){
        AF.request("https://api.openweathermap.org/data/2.5/weather?lat=-34.61315&lon=-58.37723&appid=48d90bfb1a4fb9a610f65398727f70b9").responseDecodable(of: WeatherModel.self) { (response) in
            if response.value != nil {
                self.weatherList = response.value
          }
        }
        
    }
}
