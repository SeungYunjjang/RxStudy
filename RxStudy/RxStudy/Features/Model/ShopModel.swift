//
//  ShopModel.swift
//  RxStudy
//
//  Created by andrew on 2020/01/03.
//  Copyright © 2020 Cha corp. All rights reserved.
//

import UIKit

struct ShopModel {
    
    private let dto: ShopApiModel

    let productImage: UIImage
    let name: String
    let discription: String
    
    init(_ _dto: ShopApiModel) {
        dto = _dto
        productImage = UIImage().setUrlImage(dto.imageUrl)
        name = dto.name
        discription = dto.description
    }
}

struct ShopApiResponseModel: Codable {
    let status: String
    let code: Int
    let result: ShopApiListModel?
}

struct ShopApiListModel: Codable {
    let list: [ShopApiModel]
}

struct ShopApiModel: Codable {
    let no: Int
    let name: String
    let url: String
    let imageUrl: String
    let bgImageUrl: String
    let description: String
    let subsCount: Int
    let subscription: Bool
    let talkStoreId: Int
    let display: Bool
    let imageRatio: Float
    let type: ShopType
    let orderOptions: [OrderOption]
}

struct OrderOption: Codable {
    let value: String
    let text: String
    let `default`: Bool
}

enum ShopType: String, Codable {
    case style
    case talkstore
}
