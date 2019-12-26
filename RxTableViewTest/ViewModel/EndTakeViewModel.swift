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

class EndTakeDetailViewModel {
    
    var items: BehaviorRelay<EndTakeModel> = BehaviorRelay(value: EndTakeModel.init([:]))
    var regNo: BehaviorRelay<Int> = BehaviorRelay(value: 1)
    
    func update() -> Disposable? {
        
        guard let url = URL(string: APiURls.shared.get(.end_take_detail)) else { return nil }
        let param: [String: Any] = [ "take_reg_no" : regNo.value ]
        
        let disposable = ExRequest.shared.postRequest(url: url, param: param)
            .subscribe(onNext: { (data) in
                guard let list = data["data"] as? [String: Any] else { return }
                
                self.items.accept(EndTakeModel.init(list))
                
            })
        return disposable
    }
    
}


// test

class TestViewModel {
    
    //MARK: - Input
    let setPageCount: AnyObserver<Int>
    
    let reload: AnyObserver<Void>
    
    // MARK: - Output
    let setItems: Observable<[EndTakeModel]>
    
    init() {
        let _reload = PublishSubject<Void>()
        self.reload = _reload.asObserver()
        
        let _pageCount = BehaviorSubject<Int>(value: 1)
        self.setPageCount = _pageCount.asObserver()
        
        self.setItems = Observable.combineLatest( _reload, _pageCount) { _, count in count }
            .flatMapLatest { ExRequest.shared.postRequest(url: URL(string: APiURls.shared.get(.end_take))!, param: [ "page": $0 ]) }
            .map { data in
                let lists = data["list"] as! [[String: Any]]
                return lists.map { list in EndTakeModel.init(list) } }
            

    }
    
    
}
