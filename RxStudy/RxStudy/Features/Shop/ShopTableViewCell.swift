//
//  ShopTableViewCell.swift
//  RxStudy
//
//  Created by andrew on 2020/01/03.
//  Copyright © 2020 Cha corp. All rights reserved.
//

import UIKit

class ShopTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func display(_ model: ShopModel) {
        productImageView.image = model.productImage
    }
    

}
