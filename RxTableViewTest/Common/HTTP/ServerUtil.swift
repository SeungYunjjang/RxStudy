//
//  ServerUtil.swift
//  RxTableViewTest
//
//  Created by andrew on 2019/12/17.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation


struct APiURls {
    static let shared: APiURls = APiURls()
    
    let BASE_URL: String
    
    enum URLKey: String {
        case end_take = "app/take/end_take"
        case end_take_detail = "/app/take/del_take_detail"
    }
    
    private init() {
        #if DEBUG
        BASE_URL = "http://dev1.exs-mobile.com:23080/"
        #else
        BASE_URL = "http://dev1.exs-mobile.com:23080/"
        #endif
        
    }
    
    func get(_ key: URLKey) -> String {
        return "\(BASE_URL)\(key.rawValue)"
    }
    
}
