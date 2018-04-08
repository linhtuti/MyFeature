//
//  LoginEntity.swift
//  MyF
//
//  Created by macOS on 3/26/18.
//  Copyright © 2018 macOS. All rights reserved.
//


import RealmSwift

class LoginEntity: Object, DeepCopy {
    typealias T = LoginEntity
    
    @objc private dynamic var id :Int = 1
    @objc dynamic var userId :String?   = nil
    @objc dynamic var oauthToken :String? = nil
    @objc dynamic var oauthRefreshToken :String? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func copyAlone() -> T {
        let instance = LoginEntity.init()
        instance.id = self.id
        instance.userId = self.userId
        return instance
    }
}
