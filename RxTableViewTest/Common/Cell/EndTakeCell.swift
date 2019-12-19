//
//  EndTakeCell.swift
//  RxTableViewTest
//
//  Created by andrew on 2019/12/17.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class EndTakeCell: UITableViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var spotLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var attendLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    
    func display(_ model: EndTakeModel) {
        mainImageView.image = model.mainImage
        titleLabel.text = model.title
        spotLabel.text = model.spot
        scoreLabel.text = "\(model.score)"
        attendLabel.text = "\(model.attendCount)"
        successLabel.text = "\(model.successCount)"
    }
}


