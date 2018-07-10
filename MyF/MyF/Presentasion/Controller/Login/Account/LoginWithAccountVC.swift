//
//  LoginWithAccountVC.swift
//  MyF
//
//  Created by ntq on 5/15/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginWithAccountVC: BaseVC<LoginWithAccountPresenter> {
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfRePassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginTouch(_ sender: UIButton?) {
        if tfUserName.text?.validation(with: EmailRule()) == true && tfPassword.text?.validation(with: PassRule()) == true {
            SVProgressHUD.show()
            self.presenter?.login(userName: tfUserName.text!, pass: tfPassword.text!)
        }
    }

    @IBAction func registerTouch(_ sender: UIButton?) {
        if tfUserName.text?.validation(with: EmailRule()) == true && tfPassword.text?.validation(with: PassRule()) == true {
            SVProgressHUD.show()
            self.presenter?.register(userNamed: tfUserName.text!, pass: tfPassword.text!)
        }
    }
}

// MARK: LoginWithAccountView protocol
extension LoginWithAccountVC: LoginWithAccountView {
    func loginWithAccountComplete(success: Bool) {
        SVProgressHUD.dismiss()
        if success {
            showAlertMessage(title: nil, message: "Login done")
        } else {
            showAlertMessage(title: nil, message: "Login fail")
        }
    }

    func registerWithAccountComplete(success: Bool) {
        SVProgressHUD.dismiss()
        if success {
            showAlertMessage(title: nil, message: "Register done")
        } else {
            showAlertMessage(title: nil, message: "Register fail")
        }
    }
}
