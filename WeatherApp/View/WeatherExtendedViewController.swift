//
//  WeatherExtendedViewController.swift
//  WeatherApp
//
//  Created by Nicolas Pepe on 01/02/2023.
//

import UIKit
import Combine

class WeatherExtendedViewController: UIViewController {
    
    var viewModel = WeatherViewModel()
    var anyCancellable: [AnyCancellable] = []
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var tableview: UITableView!
    var image: UIImage?
    var latLon: (String,String)?
    var wm: WeetherResponse?
    var list: [Day]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        suscripcions()
        if let valor = latLon {
            viewModel.getWeather5Days(lat: valor.0, long: valor.1)
        }
        backgroundImage.image = image
        effectImage()
        tableview.dataSource = self
        tableview.delegate = self
        tableview.backgroundColor = .clear
        tableview.register(UINib(nibName: "WeatherExtendedTableViewCell", bundle: nil), forCellReuseIdentifier: "mycustomcell")
    }
    
    func suscripcions(){
        viewModel.$weatherExtended.sink {_ in } receiveValue: { wm in
            self.wm = wm
            if let valor =
                wm?.list {
                self.list = valor
                self.tableview.reloadData()
            }
        }.store(in: &anyCancellable)
    }
    
    private func effectImage(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImage.addSubview(blurEffectView)
    }
    
    func formatted(valor: Double) -> String {
        var formated = String(format: "%.0f", valor)
        return formated
    }
    
}



extension WeatherExtendedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let valor = self.list?.count {
            return valor
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell =  tableview.dequeueReusableCell(withIdentifier: "mycustomcell", for: indexPath) as? WeatherExtendedTableViewCell
        
        if let valor = self.list?[indexPath.row].main?.temp?.rounded((.towardZero)) {
            var temp = self.list?[indexPath.row].main?.temp?.description
            
            var min = self.list?[indexPath.row].main?.temp_min
            
            var max = self.list?[indexPath.row].main?.temp_max
            
            var formated = String(format: "%.0f", valor)
            cell?.temp.text = "\(formated)ºC"
            cell?.minMax.text = "\(formatted(valor: min!))ºC / \(formatted(valor: max!))ºC"
                cell?.layoutIfNeeded()
                return cell!
        }
        return cell!
    }
}
