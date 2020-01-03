//
//  ServerUtil.swift
//  RxStudy
//
//  Created by andrew on 2020/01/02.
//  Copyright © 2020 Cha corp. All rights reserved.
//

import Foundation

struct ApiUrls {
    
    static let shared: ApiUrls = ApiUrls()
    
    let BASE_URL: String
    let IMAGE_URL: String
    
    enum URLKey: String {
        case end_take = "app/take/end_take"
        case end_take_detail = "/app/take/del_take_detail"
        
        case shop = "/shops?"
        case soho = "/soho"
    }
    
    private init() {
        #if DEBUG
        BASE_URL = "https://style.kakao.com/api/v5/tab/best"
        IMAGE_URL = "https://img1.daumcdn.net/thumb/R300x0/?fname=https%3A%2F%2Ft1.daumcdn.net%2Fkstyle"
        #else
        BASE_URL = "https://style.kakao.com/api/v5/tab/best"
        IMAGE_URL = "https://img1.daumcdn.net/thumb/R300x0/?fname=https%3A%2F%2Ft1.daumcdn.net%2Fkstyle"
        #endif
        
    }
    
    func get(_ key: URLKey) -> String {
        return "\(BASE_URL)\(key.rawValue)"
    }
    
    func getImageUrl(_ imageURL: String) -> String {
        return "\(IMAGE_URL)\(imageURL)"
    }
    
}
