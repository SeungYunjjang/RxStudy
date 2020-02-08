//
//  ShopViewModel.swift
//  RxStudy
//
//  Created by andrew on 2020/01/02.
//  Copyright © 2020 Cha corp. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ShopViewModel {
    
    private let disposeBag = DisposeBag()
    private let parameterSubject: PublishSubject<ShopList.Request> = .init()
    private let presentItems: PublishSubject<[ShopPresentModel]> = PublishSubject()
    private let shopItems: PublishSubject<ShopList.Response?> = .init()
    
    private var pageCount: PublishSubject<Int> = .init()
    private var pageSize: PublishSubject<Int> = .init()
    private var shopPresentModelArray: [ShopPresentModel] = []
    private var pageNum: Int = 0
    
    private var responseData: ShopList.Response? = nil

    init() {
        
        Observable.combineLatest(pageCount, pageSize) { count, size in
            ShopList.Request.init(page: count, size: size, conceptCategoryNos: 0)
        }
        .flatMapLatest {
            Request<KaKaoStyle<ShopList.Response>>(KakaoRouter.shopList(model: $0))
                .asObservable()
        }
        .subscribe(onNext: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                self.shopItems.onNext(data)
            case let .failure(error):
                print(error)
            }
        }, onError: { error in
            print(error)
        })
        .disposed(by: disposeBag)
        
        shopItems.compactMap { $0 }
            .map { $0.list.map { ShopPresentModel.init($0) } }
            .subscribe(onNext: { [weak self] shopPresentModelLists in
                guard let self = self else { return }
                self.shopPresentModelArray.append(contentsOf: shopPresentModelLists)
                self.presentItems.onNext(self.shopPresentModelArray)
            })
            .disposed(by: disposeBag)
        
        fetch()
    }

    private func fetch() {
        pageSize.onNext(10)
        pageCount.onNext(pageNum)
    }
    
    func scrollOnTop() {
        shopPresentModelArray = []
        pageNum = 0
        pageCount.onNext(pageNum)
    }
    
    func pageCountUpdate(_ row: Int) {
        
        if row >= (pageNum + 1) * 10 - 2 {
            pageNum += 1
            pageCount.onNext(pageNum)
        }
    }
    
    func getPresentItems() -> PublishSubject<[ShopPresentModel]> {
        return presentItems
    }
    
    func getDetailPresentModel(_ row: Int) -> ShopPresentModel {
        return shopPresentModelArray[row]
    }
    
}
