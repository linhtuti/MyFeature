//
//  FirebaseAuthRepos.swift
//  MyF
//
//  Created by macOS on 3/27/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseAuth

protocol FirebaseAuthRepos {
    func loginFir(userName: String, pass: String) -> Observable<VoidEntity>
    func registerFir(userName: String, pass: String) -> Observable<VoidEntity>
    func loginWithGoogle(id: String, token: String) -> Observable<VoidEntity>
    func loginWithFacebook(token: String) -> Observable<VoidEntity>
}
