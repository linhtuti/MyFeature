//
//  LoginUserCase.swift
//  MyF
//
//  Created by ntq on 4/24/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
import RxSwift

class LoginUseCase {
    private var loginRepos: LoginRepos!

    init(_ loginRepos: LoginRepos) {
        self.loginRepos = loginRepos
    }

    func exe(userName: String, password: String) -> Observable<VoidEntity> {
        return Observable<VoidEntity>.create({ observable -> Disposable in
            self.loginRepos.requestLogin(userId: userName, pass: password).subscribe(onNext: { (loginEntity: LoginEntity) in
                do{
                    try self.loginRepos.setLogin(userId: loginEntity.userId ?? "", token: loginEntity.oauthToken, refreshToken: loginEntity.oauthRefreshToken)
                    observable.onNext(VoidEntity())
                    observable.onCompleted()
                } catch let error {
                    observable.onError(error)
                    DLOG(error.localizedDescription)
                }
            }, onError: { error in
                observable.onError(error)
            })
        })
    }
}
