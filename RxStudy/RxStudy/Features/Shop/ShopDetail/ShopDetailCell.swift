//
//  ShopDetailCell.swift
//  RxStudy
//
//  Created by andrew on 2020/01/10.
//  Copyright © 2020 Cha corp. All rights reserved.
//

import UIKit

class ShopDetailCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    func display(_ model: ShopDetailPresentModel) {
        titleLabel.text = model.title
        likeBtn.setTitle("\(model.likeCount)", for: .normal)
    }
    
}
