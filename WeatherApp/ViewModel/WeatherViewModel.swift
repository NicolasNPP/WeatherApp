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
    func getWeather(){
        
    
        WeatherService.shared.getWeather(latitude: "-34.61315", longitude: "-58.37723") { weather in
            self.weatherList = weather
        } failure: { error in
            print(error)
        }

    }
}
