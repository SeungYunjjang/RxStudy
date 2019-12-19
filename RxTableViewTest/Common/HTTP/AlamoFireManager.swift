//
//  AlamoFireManager.swift
//  RxTableViewTest
//
//  Created by andrew on 2019/12/17.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation
import Alamofire

struct AlamofireManager {
    static var shared: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        configuration.timeoutIntervalForResource = 5
        
        let alamoFireManager = Alamofire.SessionManager(configuration: configuration)
        return alamoFireManager
    }()
    
    private init() {}
}
