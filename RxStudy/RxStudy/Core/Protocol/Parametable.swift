//
//  Parametable.swift
//  RxStudy
//
//  Created by Cha Cha on 02/01/2020.
//  Copyright © 2020 Cha corp. All rights reserved.
//

import Foundation
import Alamofire

protocol Parametable: Encodable {
    var asParameter: Parameters { get }
}

extension Parametable {
    var asParameter: Parameters {
        var parameter: Parameters?
        do {
            parameter = try JSONSerialization.jsonObject(with: JSONEncoder().encode(self)) as? Parameters
        } catch let error {
            print(error.localizedDescription)
        }
        
        return parameter ?? [:]
    }
}
