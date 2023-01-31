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
    @IBOutlet weak var backgroundImage: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscriptions()
        viewModel.getWeather(latitude: "-34.61315", longitude: "-58.37723")
        backgroundImage.image = UIImage(named: "defaultSunset")
    
    }
    
    func subscriptions(){
        viewModel.$weatherList.sink {_ in } receiveValue: { wm in
            self.wm = wm
            self.myLabel.text = wm?.name
            self.labelTemp.text = wm?.main?.temp.description
        }.store(in: &anyCancellable)
    }
 
    
    @IBAction func SwipeAction(_ sender: Any) {
        viewModel.getWeather(latitude: "-38.00042", longitude: "-57.5562")
    }
    
    
}
