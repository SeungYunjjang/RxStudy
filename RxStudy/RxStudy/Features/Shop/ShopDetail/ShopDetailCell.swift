//
//  ShopDetailCell.swift
//  RxStudy
//
//  Created by andrew on 2020/01/10.
//  Copyright © 2020 Cha corp. All rights reserved.
//

import UIKit

class ShopDetailCell: UICollectionViewCell {
    
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    func display(_ model: ShopDetailPresentModel) {
        
        if let url = URL(string: model.productImageUrl) {
            productImageView.kf.setImage(with: url)
        } else {
            productImageView.isHidden = true
        }
        
        titleLabel.text = model.title
        likeBtn.setTitle("\(model.likeCount)", for: .normal)
    }
    
}
