//
//  Router.swift
//  RxStudy
//
//  Created by Cha Cha on 30/12/2019.
//  Copyright © 2019 Cha corp. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

protocol RouterProtocol {
    var requirement: (uri: String, paramters: Parameters?, method: HTTPMethod) { get }
}

enum Remote {
    case `default`
    case kakao
    case brandy
    
    var policy: Policy {
        switch self {
        case .default, .kakao:
            return Policy(host: "https://style.kakao.com/api/", version: .v5, timeoutInterval: 5.0)
        case .brandy:
            return Policy(host: "https://brandy.com", version: .none, timeoutInterval: 10.0)
        }
    }
    
    struct Policy {
        let host: String
        let version: APIVersion
        let timeoutInterval: TimeInterval
    }
    
    enum APIVersion: String {
        case none = ""
        case v1
        case v2
        case v3
        case v4
        case v5
        case v6
        case v7
    }
}

fileprivate enum Headers: String, CaseIterable {
    case accept = "Accept"
    case language = "Accept-Language"
    case platform = "os"
    case version = "osVersion"
    case bundleId = "appVersion"
    
    var value: String {
        switch self {
        case .accept: return "application/json, text/plain, */*"
        case .language: return "en-us"
        case .platform: return "iOS"
        case .version: return UIDevice.current.systemVersion
        case .bundleId: return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        }
    }
}

fileprivate enum DefaultRequest {
    static let session: SessionManager = {
        let configration = URLSessionConfiguration.default.apply {
            var headers: [String: Any] = [:]
            Headers.allCases.forEach {
                headers[$0.rawValue] = "\($0.value)"
                print(headers)
            }
            
            $0.httpAdditionalHeaders = headers
        }
        
        return Alamofire.SessionManager(configuration: configration)
    }()
}

class Request<Response: Respondable> {
    private let requirement: (uri: String, paramters: Parameters?, method: HTTPMethod)
    private var remote: Remote = .default
    private var urlPrefix: String {
        "\(remote.policy.host)\(remote.policy.version)"
    }
    
    init(_ router: RouterProtocol) {
        requirement = router.requirement
    }
}


// MARK: - Public Setter
extension Request {
    // TODO
    func policy(with policy: Remote.Policy) -> Self {
        self
    }
    
    // TODO
    func useRequestLog() -> Self {
        self
    }
    
    // TODO
    func useErrorLog() -> Self {
        self
    }
    
    // TODO
    func useResponseLog() -> Self {
        self
    }
}

extension Request {
    private func asRequest() throws -> URLRequestConvertible {
        guard var urlComponent = URLComponents(string: "\(urlPrefix)\(requirement.uri)") else {
            throw AFError.parameterEncodingFailed(reason: .missingURL)
        }
        
        if requirement.method == .get {
            urlComponent.queryItems = requirement.paramters?.map { URLQueryItem(name: $0, value: String(describing: $1)) }
        }
        
        var request = URLRequest(url: try urlComponent.asURL())
        request.timeoutInterval = remote.policy.timeoutInterval
        request.httpMethod = requirement.method.rawValue
        
        if urlComponent.queryItems == nil, let parameter = requirement.paramters {
            do {
                 request.httpBody = try JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
            return request
    }
    
    func asObservable() -> Observable<RequestResult<Response>> {
         .create { observer -> Disposable in
            let dispose = Disposables.create {
                observer.onCompleted()
            }
            var request: URLRequestConvertible?
            do {
                 request = try self.asRequest()
            } catch let error {
                observer.onNext(.failure(error))
            }
            guard let req = request else { return dispose }
            DefaultRequest.session.request(req).responseData { response in
                switch response.result {
                case let .success(data):
                    do {
                        let responseData = try Response.decode(with: data)
                        if let data = responseData.data {
                            observer.onNext(.success(data))
                        }
                    } catch let error {
                        observer.onNext(.failure(error))
                    }
                    
                case let .failure(error):
                    observer.onNext(.failure(error))

                }
            }
            return dispose
         }
    }
    
    // TODO: multipart request
    func asObservable(_ file: Data) -> Observable<RequestResult<Response>> {
        .create { observer -> Disposable in
            
            return Disposables.create()
        }
    }
}

// ===========================================================
// ===================      Sample      ======================
// ===========================================================
/*
struct TestData: Codable {
    let shopList: [Shop]
}

struct Shop: Codable {
    let name: String
}

struct RequestModel: Parametable {
    let size: Int
}


enum KakaoRouter {
    case shopRank(size: Int)
    case shopRankModel(model: RequestModel)
}

extension KakaoRouter: RouterProtocol {
    var requirement: (uri: String, paramters: Parameters?, method: HTTPMethod) {
        switch self {
        case let .shopRank(size):
            return ("/shop/recommendShops/shopRank", ["size": size], .get)
        case let .shopRankModel(model):
            return ("/shop/recommendShops/shopRank", model.asParameter, .get)
        }
    }
}
*/
