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
    let extra: String?
    
    private enum CodingKeys: String, CodingKey {
        case status, code, data = "result", extra
    }
}
