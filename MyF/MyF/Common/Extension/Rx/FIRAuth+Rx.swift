//
//  FIRAuth+Rx.swift
//  Utility
//
//  Created by aqu on 12/18/17.
//  Copyright © 2017 Unity Mac. All rights reserved.
//

import Foundation
import FirebaseAnalytics
import FirebaseAuth
import RxSwift
/*
 var refUserOnline = Database.database().reference(withPath: "onlines")
 guard let u = usr else {return}
 let userChild = self?.refUserOnline.child(u.uid)
 userChild?.setValue(u.email)
 */


extension Reactive where Base: Auth {
    
    var addStateDidChangeListener:Observable<(Auth, User?)> {
        return Observable<(Auth, User?)>.create({ (observable) -> Disposable in
            let listener = self.base.addStateDidChangeListener({ (auth, user) in
                observable.onNext((auth, user))
            })
            
            return Disposables.create {
                self.base.removeStateDidChangeListener(listener)
            }
        })
    }
    
    
    func signIn(userName: String, password: String) -> Observable<User?> {
        return Observable<User?>.create({ (observable) -> Disposable in
            self.base.signIn(withEmail: userName, password: password) { (user, error) in
                guard error == nil else {
                    observable.onError(error!)
                    return
                }
                
                observable.onNext(user)
                observable.onCompleted()
            }
            return Disposables.create()
        })
    }
    
    func signIn(with credential:AuthCredential) -> Observable<User?> {
        return Observable<User?>.create({ (observable) -> Disposable in
            self.base.signIn(with: credential, completion: { (user, error) in
                if error != nil {
                    observable.onError(error!)
                } else {
                    
                    observable.onNext(user)
                    observable.onCompleted()
                }
            })
            
            return Disposables.create()
        })
    }
    
    func createUser(_ userName:String,_ password: String) -> Observable<User?>{
        return Observable<User?>.create({ (observable) -> Disposable in
            self.base.createUser(withEmail: userName, password: password) { (user, error) in
                if error != nil {
                    observable.onError(error!)
                } else {
                
                    observable.onNext(user)
                    observable.onCompleted()
                }
            }
            return Disposables.create()
        })
    }
    
    
}
