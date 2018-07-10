//
//  LoginPresenter.swift
//  MyF
//
//  Created by ntq on 4/24/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
import RxSwift

class LoginPresenter: NSObject, Presenter {
    typealias V = LoginView
    weak var view: V?

    func attach<V>(_ view: V) where V : BaseView {
        self.view = view as? LoginView
    }

    private var modelUseCase: LoginUseCase!

    var coordinator: LoginCoordinator?

    init(_ modelUseCase: LoginUseCase, coordinator: LoginCoordinator) {
        self.coordinator = coordinator
        self.modelUseCase = modelUseCase
    }

    func gotoAccountLogin() {
        coordinator?.gotoAccountManager()
    }

    func loginWithGoogle(id: String, token: String) {
        modelUseCase.exeLoginWithGoogle(id: id, token: token).subscribe(onNext: {[weak self] _ in
            self?.view?.loginWithGoogleSuccess(success: true)
        }, onError: {[weak self] _ in
            self?.view?.loginWithGoogleSuccess(success: false)
        }).disposed(by: self.rx_disposeBag)
    }

    func loginWithFacebook(token: String) {
        modelUseCase.exeLoginWithFacebook(token: token)
            .subscribeOn(SerialDispatchQueueScheduler.init(qos: DispatchQoS.default))
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: {[weak self] _ in
                self?.view?.loginWithFacebookSuccess(success: true)
                }, onError: {[weak self] _ in
                self?.view?.loginWithFacebookSuccess(success: false)
            }).disposed(by: self.rx_disposeBag)
    }
}
