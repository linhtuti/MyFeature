//
//  LoginDao.swift
//  MyF
//
//  Created by macOS on 3/28/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
import RealmSwift

class LoginDao: RealmDao<LoginEntity> {
    func createOrUpdate(_ userId: String, token: String?, tokenRefresh: String?) throws {
        let loginEntity = LoginEntity()
        
        loginEntity.userId = userId
        loginEntity.oauthToken = token
        loginEntity.oauthRefreshToken = tokenRefresh
        
        try super.createOrUpdate(loginEntity)
    }
    
    func getOauthToken() throws -> String? {
        let loginEntity = try find(LoginEntity.self)?.copyAlone()
        return loginEntity?.oauthToken
    }
    
    func getRefeshOauthToken() throws -> String? {
        let loginEntity = try find(LoginEntity.self)?.copyAlone()
        return loginEntity?.oauthRefreshToken
    }
    
    func setOauthToken(token: String?, refreshToken: String?) throws -> Void {
        let realm = try Realm()
        
        if let loginEntity =  realm.objects(LoginEntity.self).first {
            try realm.write {
                loginEntity.oauthToken = token
                loginEntity.oauthRefreshToken = refreshToken
            }
        }
    }
}
