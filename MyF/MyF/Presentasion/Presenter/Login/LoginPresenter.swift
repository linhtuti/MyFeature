//
//  LoginPresenter.swift
//  MyF
//
//  Created by ntq on 4/24/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation

class LoginPresenter: BasePresenter {
    typealias T = LoginView

    var modelUseCase: LoginUseCase!

    init(_ modelUseCase: LoginUseCase) {
        self.modelUseCase = modelUseCase
    }
}
