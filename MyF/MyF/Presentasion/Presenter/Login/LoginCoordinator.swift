//
//  LoginCoordinator.swift
//  MyF
//
//  Created by ntq on 5/9/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import UIKit

class LoginCoordinator: BaseCoordinator {
    private weak var rootViewController: UINavigationController?

    init(rootViewController: UINavigationController?) {
        self.rootViewController = rootViewController
    }

    override func start() {
        guard rootViewController != nil else { return }
        let loginMainVC = LoginVC(presenter: AppDIContainer.shared.main.resolve(LoginPresenter.self, argument: self)!)
        rootViewController?.setViewControllers([loginMainVC], animated: false)
        loginMainVC.title = "Start"
    }

    override func finish() {
        // 0let mainVC = 
    }
}

extension LoginCoordinator: LoginCoordinatorProtocol {
    func didFinish(from coordinator: LoginCoordinator) {
        self.removeFromChildCoordinators(coordinator: coordinator)
    }

    func gotoAccountManager() {
        let accountVC = LoginWithAccountVC(presenter: AppDIContainer.shared.main.resolve(LoginWithAccountPresenter.self, argument: self)!)
        accountVC.title = "Login with an account"
        rootViewController?.pushViewController(accountVC, animated: true)
    }
}

extension LoginCoordinator: LoginAccountCoordinatorProtocol  {
    func backToMainLogin() {
        rootViewController?.popViewController(animated: true)
    }
}
