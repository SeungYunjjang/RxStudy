//
//  ShopDetailViewModel.swift
//  RxStudy
//
//  Created by andrew on 2020/01/08.
//  Copyright © 2020 Cha corp. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ShopDetailViewModel {
    
    private typealias ComplitionHandler = () -> Void
    
    private let disposeBag = DisposeBag()
    private let shopItemsResponse: PublishSubject<ShopDetail.ItemResponse> = .init()
    private let shopDetailResponse: PublishSubject<ShopDetail.DetailResponse> = .init()
    private let shopItemsPresent: PublishSubject<[ShopDetailPresentModel]> = .init()
    private let regNo: PublishSubject<Int> = .init()
    private let shopListRequestModel: PublishSubject<ShopList.Request> = .init()
    
    private var pageNumber: Int = 0
    private var pageCount: PublishSubject<Int> = .init()
    private var pageSize: PublishSubject<Int> = .init()
    
    private var shopDetailPresentModelArray: [ShopDetailPresentModel] = []
    
    init() {
        
        Observable.combineLatest(pageCount, pageSize)
            .subscribe(onNext: {
                self.shopListRequestModel.onNext(ShopList.Request(page: $0, size: $1, conceptCategoryNos: 0))
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(regNo, shopListRequestModel)
            .flatMapLatest {
                Request<KaKaoStyle<ShopDetail.ItemResponse>>(KakaoRouter.shopItems(registerNumber: $0, model: $1))
                    .asObservable()
        }
        .subscribe(onNext: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                self.shopItemsResponse.onNext(data)
            case let .failure(error):
                print(error)
            }
        }, onError: { error in
            print(error)
        })
            .disposed(by: disposeBag)
        
        shopItemsResponse
            .map { $0.list.map { ShopDetailPresentModel.init($0) } }
             .subscribe(onNext: { [weak self] shopPresentModels in
                guard let self = self else { return }
                self.shopDetailPresentModelArray.append(contentsOf: shopPresentModels)
                self.shopItemsPresent.onNext(self.shopDetailPresentModelArray)
            })
            .disposed(by: disposeBag)
        
        fetch()
    }
    
    private func fetch() {
        pageSize.onNext(10)
        pageCount.onNext(0)
    }
    
    func getPresentItems() -> PublishSubject<[ShopDetailPresentModel]> {
        return shopItemsPresent
    }
    
    func getDetailUrl(_ row: Int) -> ShopDetailPresentModel {
        return shopDetailPresentModelArray[row]
    }
    
    func setRegisterNum(_ registerNo: Int) {
        regNo.onNext(registerNo)
    }
    
    func pageCountUpdate(_ row: Int) {
        if row >= (pageNumber + 1) * 10 - 2 {
            pageNumber += 1
            pageCount.onNext(pageNumber)
        }
    }
    
    func setPageSize(_ _pageSize: Int) {
        pageSize.onNext(_pageSize)
    }
    
}
