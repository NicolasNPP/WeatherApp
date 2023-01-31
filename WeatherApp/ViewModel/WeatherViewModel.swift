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
    
    var service = WeatherService.shared
    func getWeather(latitude: String, longitude: String){
        
    
        WeatherService.shared.getWeather(latitude: latitude, longitude: longitude) { weather in
            self.weatherList = weather
        } failure: { error in
            print(error)
        }

    }
}
