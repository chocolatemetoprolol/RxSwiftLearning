//
//  CollectionViewCell.swift
//  RxSwiftLearning
//
//  Created by lovechocolate on 2021/4/2.
//  Copyright © 2021 WR. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet var areaTipLabel: UILabel!
    @IBOutlet var dateTipLabel: UILabel!
    @IBOutlet var oneTipLabel: UILabel!
    @IBOutlet var twoTipLabel: UILabel!
    @IBOutlet var threeTipLabel: UILabel!
    @IBOutlet var fourTipLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var listModel: ListData?{
        didSet{
            guard let model = listModel  else { return }
            self.areaTipLabel.text = model.weatherRegion?.provinceName
            self.dateTipLabel?.text = model.weatherDate
            self.oneTipLabel?.text = model.weatherRegion?.cityName
            self.twoTipLabel.text = model.weatherInfo
            self.threeTipLabel.text = String(model.temperatureHigh)
            self.fourTipLabel.text = String(model.temperatureLow)
        }
    }

}
