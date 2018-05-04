//
//  LoginVC.swift
//  MyF
//
//  Created by ntq on 5/4/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import UIKit

class LoginVC: BaseVC, LoginView{
    typealias T = LoginPresenter

    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // LoginVC.init(presenter: LoginPresenter(<#T##modelUseCase: LoginUseCase##LoginUseCase#>), nibName: type(of: LoginVC.self))
    }

    @IBAction func signInAction(_ sender: UIButton?) {

    }
}

extension LoginVC {
    func loginSuccess() {
        // TODO: Something
    }
}

