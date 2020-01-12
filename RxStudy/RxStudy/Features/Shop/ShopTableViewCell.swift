//
//  ShopTableViewCell.swift
//  RxStudy
//
//  Created by andrew on 2020/01/03.
//  Copyright © 2020 Cha corp. All rights reserved.
//

import UIKit

class ShopTableViewCell: UITableViewCell {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func display(_ model: ShopPresentModel) {
        textLabel?.text = model.name
        detailTextLabel?.text = model.discription
    }
    

}
