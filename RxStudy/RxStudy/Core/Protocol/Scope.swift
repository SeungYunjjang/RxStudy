//
//  ScopeProtocol.swift
//  RxStudy
//
//  Created by Cha Cha on 30/12/2019.
//  Copyright © 2019 Cha corp. All rights reserved.
//

import Foundation

protocol HasLet {}
protocol HasApply {}

extension HasLet {
    func lets(closure: (Self) -> Void) {
        closure(self)
    }
}

extension HasApply {
    func apply(closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }
}

extension NSObject: HasApply, HasLet { }

func run<R>(closure: () -> R) -> R {
    return closure()
}

func with<T, R>(_ receiver: T, closure: (T) -> R) -> R {
    return closure(receiver)
}
