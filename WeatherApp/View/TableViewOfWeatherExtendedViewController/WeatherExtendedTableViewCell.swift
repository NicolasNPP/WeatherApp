//
//  WeatherExtendedTableViewCell.swift
//  WeatherApp
//
//  Created by Nicolas Pepe on 01/02/2023.
//

import UIKit

class WeatherExtendedTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var minMax: UILabel!
    @IBOutlet weak var temp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
