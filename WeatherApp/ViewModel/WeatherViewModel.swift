//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Nicolas Pepe on 30/01/2023.
//

import Foundation
import Combine

class WeatherViewModel {
    @Published var weatherList: [WeatherModel] = []
    //Creo subject para que se suscriban
    
    func getWeather(){
        weatherList = WeatherModel.getUsers()
    }
}
