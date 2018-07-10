//
//  MainCoordinator.swift
//  MyF
//
//  Created by ntq on 5/28/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: BaseCoordinator {
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

    }
}
