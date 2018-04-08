//
//  OAuthReposImpl.swift
//  MyF
//
//  Created by macOS on 3/25/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
import RxSwift

class OAuthReposImpl: OAuthRepos {
    // TODO: implementation method
    
    func updateOAuthToken() -> Observable<OAuthTokenEntity>? {
        
        return nil
    }
    
    func getOAuthToken() -> Observable<String> {
        
        
        return Observable<String>.from([""])
    }
    
    func getOAuthTokenSync() -> String {
        return ""
    }
    
    func getRefreshToken() -> Observable<String> {
        return Observable<String>.from([String()])
    }
    
    func setOAuthToken(oauthToken: String, refreshToken: String) -> Observable<VoidEntity> {
        return Observable<VoidEntity>.from([VoidEntity()])
    }
    
    
}
