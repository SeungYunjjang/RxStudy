//
//  KakaoRouter.swift
//  RxStudy
//
//  Created by andrew on 2020/01/07.
//  Copyright © 2020 Cha corp. All rights reserved.
//

import Foundation
import Alamofire

enum KakaoRouter {
    case shopRank(size: Int)
    //    case shopRankModel(model: )
    case shopList(model: ShopList.Request)
    case shopDetail(registerNumber: Int)
    case shopItems(registerNumber: Int, model: ShopList.Request)
}

extension KakaoRouter: RouterProtocol {
    var requirement: (uri: String, paramters: Parameters?, method: HTTPMethod) {
        switch self {
        case let .shopRank(size):
            return ("/shop/recommendShops/shopRank", ["size": size], .get)
        case let .shopList(model):
            return ("/tab/best/shops", model.asParameter, .get)
        case let .shopDetail(registerNumber):
            return ("/shop/\(registerNumber)/detail", nil, .get)
        case let .shopItems(registerNumber, model):
            return ("/shop/\(registerNumber)/items", model.asParameter, .get)
            //        case let .shopRankModel(model):
            //            return ("/shop/recommendShops/shopRank", model.asParameter, .get)
        //        }
        
        }
    }
}
