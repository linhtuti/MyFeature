//
//  OAuthRepos.swift
//  MyF
//
//  Created by macOS on 3/25/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift

protocol OAuthRepos {
    func updateOAuthToken() -> Observable<OAuthTokenEntity>?
    func getOAuthToken() -> Observable<String>
    func getOAuthTokenSync() -> String
    func getRefreshToken() -> Observable<String>
    func setOAuthToken(oauthToken: String, refreshToken: String) -> Observable<VoidEntity>
    
}
