//
//  ShopDetailPresentModel.swift
//  RxStudy
//
//  Created by 승윤 on 2020/02/05.
//  Copyright © 2020 Cha corp. All rights reserved.
//

import Foundation

struct ShopDetailPresentModel {
    
    private let dto: ShopItem
    
    let no: Int
    let title: String
    let likeCount: Int
    let productImageUrl: String
    
    let linkUrl: String
    
    init(_ _dto: ShopItem) {
        
        dto = _dto
        no = dto.no
        title = dto.title
        likeCount = dto.likeCount
        productImageUrl = "https://img1.daumcdn.net/thumb/R300x0/?fname=https%3A%2F%2Ft1.daumcdn.net%2Fkstyle\(dto.imageUrl)"
        
        linkUrl = dto.linkUrl
        
    }
}
