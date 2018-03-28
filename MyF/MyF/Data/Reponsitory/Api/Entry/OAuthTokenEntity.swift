//
//  OAuthTokenEntity.swift
//  MyF
//
//  Created by macOS on 3/25/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
import SwiftyJSON

class OAuthTokenEntity: ApiResult {
    var oauthToken: String?
    var refreshToken: String?
    
    required init(_ val: NSDictionary) {
        super.init(val)
        let json = JSON(val)
        oauthToken       = json[AppKey.oauthToken].stringValue
        refreshToken     = json[AppKey.refreshToken].stringValue
    }
}
