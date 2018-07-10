//
//  LoginVC.swift
//  MyF
//
//  Created by ntq on 5/7/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit

class LoginVC: BaseVC<LoginPresenter>, LoginView, GIDSignInDelegate, GIDSignInUIDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }

    @IBAction func loginWithAccountTouch(_ sender: UIButton?) {
        self.presenter?.gotoAccountLogin()
    }

    @IBAction func loginGoogleTouch(_ sender: UIButton?) {
        GIDSignIn.sharedInstance().signIn()
    }

    @IBAction func loginFacebookTouch(_ sender: UIButton?) {
        // Login by facebook
        FBAuthManager.shared.startLogin(from: self) { (result: FBSDKLoginManagerLoginResult?, error: Error?) in
            guard let _error = error else {
                self.presenter?.loginWithFacebook(token: result?.token.tokenString ?? "")
                return
            }
            self.showAlertMessage(title: nil, message: _error.localizedDescription)
        }
    }

    @IBAction func loginPhoneTouch(_ sender: UIButton?) {
        
    }

    @IBAction func loginTwitterTouch(_ sender: UIButton?) {}
    @IBAction func loginAnonimustlyTouch(_ sender: UIButton?) {}

    // MARK: Sign with google delegate: GIDSignInDelegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let _ = error {
            self.showAlertMessage(title: nil, message: "Error: \(error.localizedDescription)")
            return
        }

        guard let authentication = user.authentication else {
            self.showAlertMessage(title: nil, message: "Login fail")
            return
        }
        self.presenter?.loginWithGoogle(id: authentication.idToken, token: authentication.accessToken)
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // TODO: do somthing when sign out google account
    }
}

extension LoginVC {
    func loginSuccess(success: Bool) {
        if success {
            
        } else {
            self.showAlertMessage(title: nil, message: "Login Fail")
        }
    }

    func loginWithGoogleSuccess(success: Bool) {
        loginSuccess(success: success)
    }

    func loginWithFacebookSuccess(success: Bool) {
        loginSuccess(success: success)
    }
}
