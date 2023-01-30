//
//  Models.swift
//  WeatherApp
//
//  Created by Nicolas Pepe on 30/01/2023.
//

import Foundation

struct WeatherModel {
    var title: String = ""
    //var descriptionText: String = ""
    //var temp: String = ""
    //var timezone: String = ""
    
    static func getUsers() -> [WeatherModel] {
        return (1..<51).map({WeatherModel(title: "Roma \($0)")})
    }
}
