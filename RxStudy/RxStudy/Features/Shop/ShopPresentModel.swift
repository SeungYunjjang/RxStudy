//
//  ShopModel.swift
//  RxStudy
//
//  Created by andrew on 2020/01/03.
//  Copyright © 2020 Cha corp. All rights reserved.
//

import UIKit

struct ShopPresentModel {
    
    private let dto: Shop

    let no: Int
    let name: String
    let discription: String
    
    init(_ _dto: Shop) {
        dto = _dto
        
        no = dto.no
        name = dto.name
        discription = dto.description
    }
}
