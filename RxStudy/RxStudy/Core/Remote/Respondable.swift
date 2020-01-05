//
//  Responsable.swift
//  RxStudy
//
//  Created by Cha Cha on 31/12/2019.
//  Copyright © 2019 Cha corp. All rights reserved.
//

import Foundation

protocol Respondable: Codable {
    associatedtype Result
    var data: Result? { get }
}

extension Respondable {
    static func decode(with data: Data) throws -> Self {
        try JSONDecoder().decode(Self.self, from: data)
    }
}

enum RequestResult<Response: Respondable> {
    case success(Response.Result)
    case failure(Error)
}
