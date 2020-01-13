//
//  ShopDetailPresentModel.swift
//  RxStudy
//
//  Created by andrew on 2020/01/08.
//  Copyright © 2020 Cha corp. All rights reserved.
//

import Foundation


struct ShopDetailPresentModel {
    
    private let dto: ShopItem
    
    let no: Int
    let title: String
    let likeCount: Int
    let linkUrl: String
    
    
    init(_ _dto: ShopItem) {
        
        dto = _dto
        no = dto.no
        title = dto.title
        likeCount = dto.likeCount
        linkUrl = dto.linkUrl
        
    }
    
    
}
