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
            .flatMap { return self.setPresentModel($0) }
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
    
    
    
    
    
    
    /*
     
     var items: PublishSubject<[ShopModel]> = PublishSubject()
     private var pageCount: PublishSubject<Int?> = .init()
     
     private let disposeBag: DisposeBag = DisposeBag()
     
     init() {
     pageCount.compactMap { $0 }
     .flatMapLatest { pageCount -> Observable<[ShopModel]> in
     
     guard let url = URL(string: ApiUrls.shared.get(.shop)) else { return .empty()}
     
     let param: Dictionary<String, Any> = [ CONCEPTCATEGORYNOS : 0,
     PAGE : pageCount,
     SIZE : 10 ]
     
     let decoder: JSONDecoder = JSONDecoder()
     
     return RequestRouter.shared.request(url: url, param: param, method: .get)
     .compactMap { try? JSONSerialization.data(withJSONObject: $0, options: .prettyPrinted) }
     .compactMap { try? decoder.decode(ShopApiResponseModel.self, from: $0) }
     .compactMap { $0.result?.list }
     .flatMap { self.setPresentModel($0) }
     
     }
     .bind(to: items)
     .disposed(by: disposeBag)
     }
     
     func updatePageCount(_ pageNum: Int) {
     pageCount.onNext(pageNum)
     }
     
     private func setPresentModel(_ shopApiModels: [ShopApiModel]) -> Observable<[ShopModel]>{
     return Observable.create { observer  in
     
     var sendShopModel: [ShopModel] = []
     for shopApiModel in shopApiModels {
     let shopModel: ShopModel = ShopModel.init(shopApiModel)
     sendShopModel.append(shopModel)
     }
     observer.onNext(sendShopModel)
     
     return Disposables.create()
     }
     }
     */
}


