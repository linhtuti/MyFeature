//
//  AppCoordinator.swift
//  MyF
//
//  Created by ntq on 5/9/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import UIKit

class AppCoordinator: BaseCoordinator {

    lazy var rootViewController = UINavigationController()
    private var window: UIWindow?

    init(window: UIWindow?){
        self.window = window
    }

    override func start() {
        guard window != nil else { return }
        let coordinator = LoginCoordinator(rootViewController: rootViewController)
        coordinator.start()
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
    }

    override func finish() {

    }
}
