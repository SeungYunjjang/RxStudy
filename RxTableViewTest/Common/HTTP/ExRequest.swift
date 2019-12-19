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
    
    
}
