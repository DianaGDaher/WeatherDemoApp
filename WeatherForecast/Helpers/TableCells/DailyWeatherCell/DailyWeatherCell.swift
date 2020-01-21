//
//  DailyWeatherCell.swift
//  WeatherForecast
//
//  Created by Diana on 1/20/20.
//  Copyright © 2020 Diana Daher. All rights reserved.
//

import UIKit

class DailyWeatherCell: UITableViewCell {

    static let identifier = "DailyWeatherCell"
    
    @IBOutlet weak var leftTopLabel: UILabel! {
        didSet {
            leftTopLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var leftbottomLabel: UILabel! {
        didSet {
            leftbottomLabel.textColor = .gray
        }
    }
    @IBOutlet weak var rightLabel: UILabel! {
        didSet {
            rightLabel.textAlignment = .right
            rightLabel.numberOfLines = 0
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
