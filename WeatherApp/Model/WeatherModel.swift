//
//  Models.swift
//  WeatherApp
//
//  Created by Nicolas Pepe on 30/01/2023.
//

import Foundation

struct WeatherModel: Decodable {
    let name: String?
    let description: String?
    let icon: String?
    let weather: [Weather]?
    let main: Main?
}

struct Weather: Decodable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

struct Main: Decodable {
    let temp: Double?
}

