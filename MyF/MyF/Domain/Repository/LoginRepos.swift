//
//  LoginRepos.swift
//  MyF
//
//  Created by macOS on 3/29/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
import RxSwift

protocol LoginRepos {
    func requestLogin(userId: String, pass: String) -> Observable<LoginEntity>
    func setLogin(userId: String, token: String?, refreshToken: String?) throws
    func getLogin() throws -> LoginEntity?
    func deleteLogin() throws
}
