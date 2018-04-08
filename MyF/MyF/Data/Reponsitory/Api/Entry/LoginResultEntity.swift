//
//  LoginResultEntity.swift
//  MyF
//
//  Created by macOS on 3/29/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import SwiftyJSON

class LoginResultEntity: ApiResult {
    var userId:String? = nil
    var oauthToken:String? = nil
    var oauthRefreshToken:String? = nil
    
    
    required init(_ val: NSDictionary) {
        super.init(val)
        let json = JSON(val)
        
        self.userId = json[AppKey.USERID].string
        self.oauthToken = json[AppKey.OAUTHTOKEN].string
        self.oauthRefreshToken = json[AppKey.OAUTHTOKEN_REFRESH].string
    }
}
