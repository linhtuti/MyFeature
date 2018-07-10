//
//  LoginCoordinatorProtocol.swift
//  MyF
//
//  Created by ntq on 5/9/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation

protocol LoginCoordinatorProtocol {
    func didFinish(from coordinator: LoginCoordinator)

    func gotoAccountManager()
}
