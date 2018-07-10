//
//  LoginWithAccountPresenter.swift
//  MyF
//
//  Created by ntq on 5/9/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
import RxSwift

class LoginWithAccountPresenter: NSObject, Presenter {
    typealias V = LoginWithAccountView
    weak var view: V?

    var modelUseCase: LoginUseCase!
    var coordinator: LoginCoordinator?

    init(_ userCase: LoginUseCase, coordinator: LoginCoordinator) {
        super.init()
        self.modelUseCase = userCase
        self.coordinator = coordinator
    }

    func attach<V>(_ view: V) where V : BaseView {
        self.view = (view as! LoginWithAccountPresenter.V)
    }

    func login(userName: String, pass: String) {
        modelUseCase.exeLogin(userName: userName, password: pass)
            .observeOn(MainScheduler.instance)
            .subscribeOn(SerialDispatchQueueScheduler.init(qos: DispatchQoS.default))
            .retry(repeatBehavior: RepeatBehavior.imediate(attems: 1))
            .subscribe(onNext: {[weak self] _ in
                self?.view?.loginWithAccountComplete(success: true)
            }, onError: { [weak self] _ in
                self?.view?.loginWithAccountComplete(success: false)
            }).disposed(by: self.rx_disposeBag)
    }

    func register(userNamed: String, pass: String) {
        modelUseCase.exeRegister(userName: userNamed, password: pass)
            .observeOn(MainScheduler.instance)
            .subscribeOn(SerialDispatchQueueScheduler.init(qos: DispatchQoS.default))
            .subscribe(onNext: {[weak self] _ in
                self?.view?.registerWithAccountComplete(success: true)
            }, onError: {[weak self] _ in
                self?.view?.registerWithAccountComplete(success: false)
            }).disposed(by: self.rx_disposeBag)
    }
}
