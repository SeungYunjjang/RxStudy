//
//  EndTakeViewModel.swift
//  RxTableViewTest
//
//  Created by andrew on 2019/12/17.
//  Copyright © 2019 Andrew. All rights reserved.
//

import RxCocoa
import RxSwift

class EndTakeViewModel {
    
    var items: BehaviorRelay<[EndTakeModel]> = BehaviorRelay(value: [])
    var pageCount: BehaviorRelay<Int> = BehaviorRelay(value: 1)
        
    func update() -> Disposable? {
        guard let url = URL(string: APiURls.shared.get(.end_take)) else { return nil }
        
        let param: [String: Any] = [ "page" : pageCount.value ]
        
        let disposable = ExRequest.shared.postRequest(url: url, param: param)
            .subscribe(onNext: { (data) in
                guard let lists = data["list"] as? [[String: Any]] else { return }
                
                var tempArray: Array<EndTakeModel> = []
                for list in lists {
                    tempArray.append(EndTakeModel.init(list))
                }
                self.items.accept(self.items.value + tempArray)
                
            })
        return disposable
    }
    
}

// test

