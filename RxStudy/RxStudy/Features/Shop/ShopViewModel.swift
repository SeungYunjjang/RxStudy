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
    private let setItems: ReplaySubject<ShopList.Response?> = ReplaySubject.create(bufferSize: 1)
    
    private var pageCount: PublishSubject<Int> = .init()
    private var pageSize: PublishSubject<Int> = .init()
    private var pageNum: Int = 0
    private var sendShopModel: [ShopPresentModel] = []
    
    //MARK: Init
    init() {
        
        Observable.combineLatest(pageCount, pageSize) { count, size in
            ShopList.Request.init(page: count, size: size, conceptCategoryNos: 0)
        }.subscribe(onNext: { request in
            self.parameterSubject.onNext(request)
        }).disposed(by: disposeBag)
        
        parameterSubject
            .flatMapLatest {
                Request<KaKaoStyle<ShopList.Response>>(KakaoRouter.shopList(model: $0))
                    .asObservable()
        }
        .subscribe(onNext: { result in
            switch result {
            case let .success(data):
                self.setItems.onNext(data)
            case let .failure(error):
                print(error)
            }
        }, onError: { error in
            print(error)
        })
            .disposed(by: disposeBag)
        
        setItems.compactMap { $0 }
            .map { $0.list }
            .flatMap { models -> Observable<[ShopPresentModel]> in
                for model in models {
                    let shopModel: ShopPresentModel = ShopPresentModel.init(model)
                    self.sendShopModel.append(shopModel)
                }
                return Observable.of(self.sendShopModel)
        }
        .bind(to: presentItems)
        .disposed(by: disposeBag)
        
        
        fetch()
    }
    
    //MARK: Private
    private func setPresentModel(_ shopApiModels: [Shop]) -> Observable<[ShopPresentModel]>{
        return Observable.create { observer  in
            
            for shopApiModel in shopApiModels {
                let shopModel: ShopPresentModel = ShopPresentModel.init(shopApiModel)
                self.sendShopModel.append(shopModel)
            }
            observer.onNext(self.sendShopModel)
            
            return Disposables.create()
        }
    }
    
    private func fetch() {
        pageSize.onNext(20)
        pageCount.onNext(pageNum)
    }
    
    //MARK: Public
    func scrollOnTop() {
        sendShopModel = []
        pageNum = 0
        pageCount.onNext(pageNum)
    }
    
    
    
    func pageCountUpdate(_ row: Int) {
        
        if row >= (pageNum + 1) * 20 - 2 {
            pageNum += 1
            pageCount.onNext(pageNum)
        }
    }
    
    func getPresentItems() -> PublishSubject<[ShopPresentModel]> {
        return presentItems
    }
    
    func getDetailPresentModel(_ row: Int) -> ShopPresentModel {
        return sendShopModel[row]
    }
    
}


