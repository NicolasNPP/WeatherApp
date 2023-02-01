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
    @Published var icon: String?
    @Published var description: String?
    @Published var backgroundImageWeather: UIImageView?
    @Published var minMax: (Double?,Double?)?
    @Published var weatherExtended: WeetherResponse?
    @Published var imgWeatherDay: WeetherResponse?
    
    //Creo subject para que se suscriban
 
    
    var service = WeatherService.shared
    func getWeather(latitude: String, longitude: String){
        
        self.loading = true
        WeatherService.shared.getWeather(latitude: latitude, longitude: longitude) { weather in
            self.weatherList = weather
            self.loading = false
            
            self.icon = weather.weather?[0].icon
            
            self.description = weather.weather?[0].description
           
            
            self.minMax = (weather.main?.temp_min,weather.main?.temp_max)
            
        } failure: { error in
            print(error)
            self.loading = false
        }
    }
    
    func getWeather5Days(lat: String, long: String){
        WeatherService.shared.getWather5Days(latitude: lat, longitude: long) { weather in
            //print(weather.list)
            self.weatherExtended = weather
        } failure: { error in
            print(error)
            self.loading = false
        }
    }
    
    func getIcon(named: String){
        let im = WeatherService.shared.getIcon(name: named)
            self.imageWeather = im
    }
    
    
}
