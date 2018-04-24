//
//  LoginVC.swift
//  MyF
//
//  Created by ntq on 4/24/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import UIKit

class LoginVC: BaseVC, LoginView{
    typealias T = LoginPresenter

    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension LoginVC {
    func loginSuccess() {
        // TODO: Something
    }
}
