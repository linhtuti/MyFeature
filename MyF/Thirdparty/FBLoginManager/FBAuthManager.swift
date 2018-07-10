//
//  FBAuthManager.swift
//  MyF
//
//  Created by ntq on 5/25/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
import FBSDKLoginKit

class FBAuthManager {
    static let shared: FBAuthManager = FBAuthManager()
    private lazy var fbLoginManager: FBSDKLoginManager = FBSDKLoginManager()
    var loginPermission: [Any] = ["public_profile", "email"]

    func startLogin(from vc: UIViewController, completionBlock: @escaping (FBSDKLoginManagerLoginResult?, Error?) ->Void)  {
        self.fbLoginManager.logIn(withReadPermissions: loginPermission, from: vc, handler: completionBlock)
    }

    func checkLogined() -> Bool {
        return FBSDKAccessToken.current() != nil
    }
}
