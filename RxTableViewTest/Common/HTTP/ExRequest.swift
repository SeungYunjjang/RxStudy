//
//  ExRequest.swift
//  RxTableViewTest
//
//  Created by andrew on 2019/12/17.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ExRequest {
    
    public static var shared: ExRequest = {
        return ExRequest()
    }()
    
    func postRequest(url: URL, param: [String: Any]) -> Observable<[String: Any]> {
        
        return Observable<[String: Any]>.create { observer in
            
            AlamofireManager.shared.request(url, method: .post, parameters: param)
                .responseJSON { (response) in
                    switch response.result {
                        
                    case .success(let data):
                        guard let _data = data as? [String: Any] else { return }
                        
                        observer.onNext(_data)
                    case .failure(let error):
                        observer.onError(error)
                    }
                    observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    func getRequest(url: URL) -> Observable<[String: Any]> {
        return Observable<[String: Any]>.create { observer in
            
            AlamofireManager.shared.request(url, method: .get)
                .responseJSON { (response) in
                    
                    
            }
            return Disposables.create()
        }
    }
    
    
    func getPageList(byPageCount pageCount: Int) -> Observable<[EndTakeModel]> {
        
        let url = URL(string: APiURls.shared.get(.end_take))!
        var request = URLRequest(url: url)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let postString = "page=\(pageCount)"
        request.httpBody = postString.data(using: .utf8)
        
        return URLSession.shared.rx
            .json(request: request)
            .flatMap { response -> Observable<[EndTakeModel]> in
                guard let _response = response as? [String: Any],
                    let items = _response["list"] as? [[String: Any]]
                    else {
                        return Observable.error(SeerviceError.cannotParse)
                }
                let _items = items.compactMap { item in
                    EndTakeModel.init(item)
                }
                return Observable.just(_items)
        }
    }
    
}


enum SeerviceError: Error {
    case cannotParse
}
