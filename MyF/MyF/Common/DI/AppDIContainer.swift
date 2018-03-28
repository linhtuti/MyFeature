//
//  AppDIContainer.swift
//  MyF
//
//  Created by macOS on 3/25/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
import Swinject

class AppDIContainer {
    static let shared: AppDIContainer = AppDIContainer()
    
    let main: Container = Container()
    
    init() {
        
    }
    
    func setupMain() {
        self.main.register(OAuthRepos.self) { (r) -> OAuthRepos in
            return OAuthReposImpl()
        }
    }
}
