//
//  LoginReposImpl.swift
//  MyF
//
//  Created by macOS on 3/30/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
import RxSwift

class LoginReposImpl: LoginRepos {

    private var dao: LoginDao?
    
    init(dao: LoginDao) {
        self.dao = dao
    }
    
    func requestLogin(userId: String, pass: String) -> Observable<LoginEntity> {
        return Observable<LoginEntity>.create({ observable -> Disposable in
            return Disposables.create()
        })
    }
    
    func setLogin(userId: String, token: String?, refreshToken: String?) throws {
        try self.dao?.createOrUpdate(userId, token: token, tokenRefresh: refreshToken)
    }
    
    func getLogin() throws -> LoginEntity? {
        return try self.dao?.find(LoginEntity.self)
    }
    
    func deleteLogin() throws {
        try self.dao?.delete()
    }
}
