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
    var locations: [(String,String)] = [("-34.61315","-58.37723"),("-38.00042","-57.5562")]
    
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        subscriptions()
        viewModel.getWeather(latitude: "-34.61315", longitude: "-58.37723")
        backgroundImage.image = UIImage(named: "defaultSunset")
    
    }
    
    func subscriptions(){
        activityIndicator.hidesWhenStopped = true
        viewModel.$weatherList.sink {_ in } receiveValue: { wm in
            self.wm = wm
            self.myLabel.text = wm?.name
            self.labelTemp.text = wm?.main?.temp.description
        }.store(in: &anyCancellable)
        
        viewModel.$loading.sink { state in
            guard let state = state else {return}
            self.configLoading(state: state)
        }.store(in: &anyCancellable)
    }
 
    private func configLoading(state: Bool) {
        if state {
            activityIndicator.startAnimating()
        } else {activityIndicator.stopAnimating()}
    }
    
    @IBAction func SwipeAction(_ sender: Any) {
        viewModel.getWeather(latitude: "-38.00042", longitude: "-57.5562")
    }
}
