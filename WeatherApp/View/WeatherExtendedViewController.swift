//
//  WeatherExtendedViewController.swift
//  WeatherApp
//
//  Created by Nicolas Pepe on 01/02/2023.
//

import UIKit

class WeatherExtendedViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    var image: UIImage?
    var latLon: (String,String)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage.image = image
        effectImage()
    }
    
    private func effectImage(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImage.addSubview(blurEffectView)
    }
}
