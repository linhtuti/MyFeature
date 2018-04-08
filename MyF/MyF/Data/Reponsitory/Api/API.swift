//
//  API.swift
//  MyF
//
//  Created by macOS on 3/27/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class API<T> {
    private let repos: OAuthRepos
    private let disposeBags = DisposeBag()
    
    init() {
        self.repos = AppDIContainer.shared.main.resolve(OAuthRepos.self)!
    }
    
    func request() -> Observable<T> {
        return Observable<T>.create({ observable -> Disposable in
            self.request(observable: observable)
            
            return Disposables.create()
        })
    }
    
    func request(observable: AnyObserver<T>) {
        let request = Alamofire.request(self.requestUrl(), method: self.method(), parameters: self.params(), encoding: self.encoding(), headers: self.headers()).responseJSON { (dataResponse) in
            DLOG("APIResponse: \(dataResponse.debugDescription)")
            
            switch dataResponse.result {
            case .success(let value):
                break
                
            case .failure(let error):
                DLOG(error.localizedDescription)
            }
        }
    }
    
    
    func requestUrl() -> String {
        return try! baseUrl() + path()
    }
    
    func baseUrl() -> String {
        return AppUtils.apiUrl()
    }
    
    func path() throws -> String {
        throw NSError()
    }
    
    func method() -> HTTPMethod{
        return HTTPMethod.get
    }
    
    func encoding() -> ParameterEncoding {
        return URLEncoding.default
    }
    
    func params() -> Parameters {
        return [:]
    }
    
    func headers() -> HTTPHeaders {
        return [
            "X-Session-Token" : repos.getOAuthTokenSync(),
            "Accept-Language" : "<lang>"
        ]
    }
}
