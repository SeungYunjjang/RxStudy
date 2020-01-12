//
//  RequestRouter.swift
//  RxStudy
//
//  Created by andrew on 2020/01/02.
//  Copyright © 2020 Cha corp. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class RequestRouter {
    
    public static var shared: RequestRouter = {
        return RequestRouter()
    }()
    
    private let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        configuration.timeoutIntervalForResource = 5
        let alamoFireManager = Alamofire.SessionManager(configuration: configuration)
        return alamoFireManager
    }()
    
    
    /// - Parameters:
    ///     - url: URL
    ///     - param: Parameter  key / value
    ///     - method: HTTP Request methoed
    /// - Returns: Obserable Response Data
    ///
    func request(url: URL, param: [String: Any], method: HTTPMethod) -> Observable<[String: Any]> {
        
        if method == .get {
            guard let _parameter = param.queryString(),
                let _url = URL(string: "\(url.absoluteString)\(_parameter)")
                else {
                return getRequest(url: url)
            }
            return getRequest(url: _url)
            
        } else {
            return postRequest(url: url, param: param)
        }
    }
    
    
    private func postRequest(url: URL, param: [String: Any]) -> Observable<[String: Any]> {
        return Observable<[String: Any]>.create { obserber in
            self.sessionManager.request(url, method: .post, parameters: param)
                .responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        guard let _data = data as? [String: Any] else { return }
                        obserber.onNext(_data)
                    case .failure(let error):
                        obserber.onError(error)
                    }
                    obserber.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    private func getRequest(url: URL) -> Observable<[String: Any]> {
        
        return Observable<[String: Any]>.create { obserber in
            self.sessionManager.request(url, method: .get)
                .responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        guard let _data = data as? [String: Any] else { return }
                        obserber.onNext(_data)
                    case .failure(let error):
                        obserber.onError(error)
                    }
                    obserber.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    
}
