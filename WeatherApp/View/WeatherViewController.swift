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
    var wm: WeatherModel?
    var anyCancellable: [AnyCancellable] = []
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscriptions()
        viewModel.getWeather()
    }
    
    func subscriptions(){
        viewModel.$weatherList.sink {_ in } receiveValue: { wm in
            self.wm = wm
            self.myLabel.text = wm?.name
            self.labelTemp.text = wm?.main.temp.description
        }.store(in: &anyCancellable)
    }
}
