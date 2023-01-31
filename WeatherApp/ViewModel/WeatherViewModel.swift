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
        }

    }
    
    func getIcon(name: String){
        let url = " http://openweathermap.org/img/wn/\(name)@2x.png"
        print(url)
        self.imageWeather?.kf.setImage(with: URL(string: url))
    }
}
