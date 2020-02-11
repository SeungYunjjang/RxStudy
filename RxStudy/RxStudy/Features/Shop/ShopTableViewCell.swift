//
//  ShopTableViewCell.swift
//  RxStudy
//
//  Created by andrew on 2020/01/03.
//  Copyright © 2020 Cha corp. All rights reserved.
//

import UIKit
import Kingfisher

class ShopTableViewCell: UITableViewCell {

    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subscriptLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func display(_ model: ShopPresentModel) {
        
        if let url = URL(string: model.productImageUrl) {
            productImageView.kf.setImage(with: url)
        } else {
            productImageView.isHidden = true
        }
        
        titleLabel.text = model.name
        subscriptLabel.text = model.discription
    }

}
