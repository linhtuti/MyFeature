//
//  LoginWithAccountView.swift
//  MyF
//
//  Created by ntq on 5/7/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation

protocol LoginWithAccountView: BaseView {
    func loginWithAccountComplete(success: Bool)
    func registerWithAccountComplete(success: Bool)
}
