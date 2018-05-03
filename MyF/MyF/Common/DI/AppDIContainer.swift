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

        // Reposibility
        self.main.register(LoginRepos.self) { r in
            return LoginReposImpl(dao: LoginDao())
        }



        // UseCase
        self.main.register(LoginUseCase.self) { r in
            return LoginUseCase(r.resolve(LoginRepos.self)!)
        }

    }
}
