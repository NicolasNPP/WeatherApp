//
//  Weather5Days.swift
//  WeatherApp
//
//  Created by Nicolas Pepe on 31/01/2023.
//

import Foundation

struct WeetherResponse: Decodable {
    let list: [Day]?
    let city: City?
    
}

struct City: Decodable {
    let name: String?
}

struct MainDay: Decodable {
    let temp: Double?
    let temp_min: Double?
    let temp_max: Double?
}

struct WeatherDay: Decodable {
    let icon: String?
    let main: String?
}

struct Day: Decodable {
    let dt: Int?
    let main: MainDay?
    let weather: [WeatherDay]?
}
