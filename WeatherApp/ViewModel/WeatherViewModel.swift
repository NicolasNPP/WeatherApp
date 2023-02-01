//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Nicolas Pepe on 30/01/2023.
//

import Foundation
import Combine
import Alamofire
import Kingfisher
import UIKit

class WeatherViewModel {
    @Published var weatherList: WeatherModel?
    @Published var loading: Bool?
    @Published var imageWeather: UIImageView?
    //Creo subject para que se suscriban
    
    var service = WeatherService.shared
    func getWeather(latitude: String, longitude: String){
        
        self.loading = true
        WeatherService.shared.getWeather(latitude: latitude, longitude: longitude) { weather in
            self.weatherList = weather
            self.loading = false
            self.getIcon(name: "01d")
        } failure: { error in
            print(error)
            self.loading = false
        }
    }
    
    func getWeather5Days(){
        WeatherService.shared.getWather5Days(latitude: "-38.00042", longitude: "-57.5562") { weather in
           print(weather)
        } failure: { error in
            print(error)
            self.loading = false
        }
    }
    
    func getIcon(name: String){
            var im = WeatherService.shared.getIcon()
            self.imageWeather = im
    }
}
