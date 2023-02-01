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
    var locations: [(String,String)] = [("23.634501","-102.552784"),("-34.61315","-58.37723"),("-38.00042","-57.5562") ,("-54.554047","-67.225258")]
    var numTemp = 0
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imwea: UIImageView!
    @IBOutlet weak var buttonNextScreen: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var minMaxLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelTemp.text = ""
        activityIndicator.startAnimating()
        subscriptions()
        viewModel.getWeather(latitude: locations[0].0, longitude: locations[0].1)
        backgroundImage.image = UIImage(named: "defaultSunset")
        effectImage()
        pageControl.numberOfPages = locations.count
        pageControl.currentPage = self.numTemp
    }
    
    func subscriptions(){
        activityIndicator.hidesWhenStopped = true
        viewModel.$weatherList.sink {_ in } receiveValue: { wm in
            self.wm = wm
            self.myLabel.text = wm?.name
            if let valor =
                wm?.main?.temp?.rounded((.towardZero)) {
                var formated = String(format: "%.0f", valor)
                self.labelTemp.text? = "\(formated)ºC"
                self.buttonNextScreen.isHidden = false
            }
        }.store(in: &anyCancellable)
        
        viewModel.$loading.sink { state in
            guard let state = state else {return}
            self.configLoading(state: state)
        }.store(in: &anyCancellable)
        
        viewModel.$imageWeather.sink { state in
            if let valor = state {
                self.imwea.image = valor.image
            }
        }.store(in: &anyCancellable)
        
        viewModel.$icon.sink { state in
            if let valor = state {
                self.viewModel.getIcon(named: valor)
            }
        }.store(in: &anyCancellable)
        
        viewModel.$description.sink { state in
            if let valor = state {
                self.backgroundImage.image = UIImage(named: "\(state!)")
                self.descriptionLabel.text = state?.capitalizingFirstLetter()
                self.descriptionLabel.isHidden = false
                
            }
        }.store(in: &anyCancellable)
        
        viewModel.$minMax.sink { state in
            if let valor = state {
                var formated = String(format: "%.0f", valor.0!)
                var formated2 = String(format: "%.0f", valor.1!)
                self.minMaxLabel.text? = "Min: \(formated)ºC / Max: \(formated2)ºC"
                self.minMaxLabel.isHidden = false
            }
        }.store(in: &anyCancellable)
    }
 
    private func configLoading(state: Bool) {
        if state {
            activityIndicator.startAnimating()
        } else {activityIndicator.stopAnimating()}
    }
    
    private func effectImage(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImage.addSubview(blurEffectView)
    }
    
    func nextLocation(){
        var arraySize = self.locations.count
        if self.numTemp <= arraySize-1 {
            if self.numTemp == arraySize-1 {
                self.numTemp = 0
            } else {
                self.numTemp += 1
            }
            var temp = locations[self.numTemp]
            viewModel.getWeather(latitude: temp.0, longitude: temp.1)
        }
        pageControl.currentPage = self.numTemp
    }
    
    func backLocation(){
        var arraySize = self.locations.count
        if self.numTemp <= arraySize-1 {
            if self.numTemp <= 0 {
                self.numTemp = arraySize-1
            } else {
                self.numTemp -= 1
            }
            var temp = locations[self.numTemp]
            viewModel.getWeather(latitude: temp.0, longitude: temp.1)
        }
        pageControl.currentPage = self.numTemp
    }
    
    @IBAction func SwipeAction(_ sender: Any) {
        nextLocation()
    }
    
    @IBAction func SwipeLeftAction(_ sender: Any) {
        backLocation()
    }
 
    @IBAction func nextScreen(_ sender: Any) {
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSegue" {
            if let destino = segue.destination as? WeatherExtendedViewController {
                destino.image = self.backgroundImage.image
                destino.latLon = locations[numTemp]
            }
        }
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
