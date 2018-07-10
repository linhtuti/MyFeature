//
//  FirebaseAuthReposImpl.swift
//  MyF
//
//  Created by ntq on 5/15/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
import Firebase
import RxSwift
import FirebaseAuth
import GoogleSignIn

class FirebaseAuthReposImpl: FirebaseAuthRepos {

    func loginFir(userName: String, pass: String) -> Observable<VoidEntity> {
        return Observable<VoidEntity>.create { observable -> Disposable in
            Auth.auth().signIn(withEmail: userName, password: pass, completion: { (userName, error) in
                guard let _error = error else {
                    observable.onNext(VoidEntity())
                    return
                }
                observable.onError(_error)
            })

            return Disposables.create()
        }
    }

    func registerFir(userName: String, pass: String) -> Observable<VoidEntity> {
        return Observable<VoidEntity>.create({ observable -> Disposable in
            Auth.auth().createUser(withEmail: userName, password: pass, completion: { (user, error) in
                guard let _error = error else {
                    observable.onNext(VoidEntity())
                    return
                }

                observable.onError(_error)
            })

            return Disposables.create()
        })
    }

    func loginWithGoogle(id: String, token: String) -> Observable<VoidEntity> {
        return Observable<VoidEntity>.create({ observable -> Disposable in
            Auth.auth().signInAndRetrieveData(with: GoogleAuthProvider.credential(withIDToken: id, accessToken: token), completion: { (authResultData, error) in
                guard let _error = error else {
                    observable.onNext(VoidEntity())
                    observable.onCompleted()
                    return
                }

                observable.onError(_error)
            })
            return Disposables.create()
        })
    }

    func loginWithFacebook(token: String) -> Observable<VoidEntity> {
        return Observable<VoidEntity>.create({ observable -> Disposable in
            Auth.auth().signInAndRetrieveData(with: FacebookAuthProvider.credential(withAccessToken: token), completion: { (authResultData, error) in
                guard let _error = error else {
                    observable.onNext(VoidEntity())
                    observable.onCompleted()
                    return
                }

                observable.onError(_error)
            })
            return Disposables.create()
        })
    }
}
