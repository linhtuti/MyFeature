//
//  LoginUserCase.swift
//  MyF
//
//  Created by ntq on 4/24/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseAuth

class LoginUseCase {
    private var loginRepos: LoginRepos!
    private var frAuthRepos: FirebaseAuthRepos!

    init(_ loginRepos: LoginRepos, frAuthRepos: FirebaseAuthRepos) {
        self.loginRepos = loginRepos
        self.frAuthRepos  = frAuthRepos

    }

    func exeLogin(userName: String, password: String) -> Observable<VoidEntity> {
        return frAuthRepos.loginFir(userName: userName, pass: password)
    }

    func exeRegister(userName: String, password: String) -> Observable<VoidEntity> {
        return frAuthRepos.registerFir(userName: userName, pass: password)
    }

    func exeLoginWithGoogle(id: String, token: String) -> Observable<VoidEntity> {
        return frAuthRepos.loginWithGoogle(id: id, token: token)
    }

    func exeLoginWithFacebook(token: String) -> Observable<VoidEntity> {
        return frAuthRepos.loginWithFacebook(token: token)
    }
}
