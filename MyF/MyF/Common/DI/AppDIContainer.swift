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
        setupMain()
    }
    
    func setupMain() {
        self.main.register(OAuthRepos.self) { (r) -> OAuthRepos in
            return OAuthReposImpl()
        }

        // Reposibility
        self.main.register(LoginRepos.self) { r in
            return LoginReposImpl(dao: LoginDao())
        }

        self.main.register(FirebaseAuthRepos.self) { r in
            return FirebaseAuthReposImpl()
        }

        // UseCase
        self.main.register(LoginUseCase.self) { r in
            return LoginUseCase(r.resolve(LoginRepos.self)!, frAuthRepos: r.resolve(FirebaseAuthRepos.self)!)
        }

        // Presenter
        self.main.register(LoginPresenter.self) { (r: Resolver, coordinator: LoginCoordinator) in
            return LoginPresenter(r.resolve(LoginUseCase.self)!, coordinator: coordinator)
        }

        self.main.register(LoginWithAccountPresenter.self) { (r: Resolver, coordinator: LoginCoordinator) in
            return LoginWithAccountPresenter(r.resolve(LoginUseCase.self)!, coordinator: coordinator)
        }

        // Main presenter
        self.main.register(MainPresenter.self) { (r, coordinator: MainCoordinator) in
            return MainPresenter(coordinator)
        }
    }
}
