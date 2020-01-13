//
//  ShopDetailApiModel.swift
//  RxStudy
//
//  Created by andrew on 2020/01/08.
//  Copyright © 2020 Cha corp. All rights reserved.
//

import Foundation

enum ShopDetail {
    
    struct DetailResponse: Codable {
        let models: [ShopDetailModels]
        let shop: Shop
        let itemList: [ShopItem]
        let shopConceptList: ShopDetailConceptList
    }
    
    struct ItemResponse: Codable {
        let list: [ShopItem]
    }
    
}

struct ShopItem: Codable {
    
    let no: Int
    let title: String
    let shopNo: Int
    let shopName: String
    let likeCount: Int
    let imageUrl: String
    let cateNo: Int
    let salePrice: Int
    let stdPrice: Int
    let linkUrl: String
    let pcLinkUrl: String?
    let talkStorePrdId: Int
    let talkStoreSaleStatus: String?
    let likeNo: Int
    let display: Bool
    let freeShipping: Bool
    let imageList: String?
    let imageRatio: Float
    let type: ShopType
    
}

struct ShopDetailModels: Codable {
    let name: String
    let height: Int
    let topSize: Int
    let bottomSize: Int
    let size: String
}

struct ShopDetailConceptList: Codable {
    let no: Int
    let name: String
    let type: String
    let color: String?
}
