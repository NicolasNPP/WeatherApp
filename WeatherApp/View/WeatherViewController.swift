//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Nicolas Pepe on 30/01/2023.
//

import UIKit
import Combine

class WeatherViewController: UIViewController {

    var viewModel = WeatherViewModel()
    var lista: [WeatherModel] = []
    var anyCancellable: [AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscriptions()
        viewModel.getWeather()
        print(viewModel.weatherList.count)
    }
    
    func subscriptions(){
        viewModel.$weatherList.sink {_ in } receiveValue: { list in
            self.lista = list
        }.store(in: &anyCancellable)
    }
}
