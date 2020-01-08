//
//  KakaoAPIModel.swift
//  RxStudy
//
//  Created by Cha Cha on 30/12/2019.
//  Copyright © 2019 Cha corp. All rights reserved.
//

import Foundation

struct KaKaoStyle<Result: Codable>: Respondable {
    let status: String
    let code: Int
    let data: Result?
    
    private enum CodingKeys: String, CodingKey {
        case status, code, data = "result"
    }
}

enum ShopList {
    struct Request: Parametable {
        let page: Int
        let size: Int
        let conceptCategoryNos: Int
    }
    
    struct Response: Codable {
        let list: [Shop]
    }
}

struct Shop : Codable {
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

struct OrderOption : Codable {
    let value: String
    let text: String
    let isDefaulted: Bool
    
    private enum CodingKeys: String, CodingKey {
        case value, text, isDefaulted = "default"
    }
    
}

enum ShopType : String, Codable {
    case style
    case talkstore
}
