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
    
}


