//
//  Coordinator.swift
//  MyF
//
//  Created by ntq on 5/9/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation

protocol Coordinator: class {
    func addToChildCoordinators(coordinator: Coordinator)

    func removeFromChildCoordinators(coordinator: BaseCoordinator)

    func removeAllChildCoordinatorsWith<T>(type: T.Type)

    func removeAllChildCoordinators()

    func start()

    func finish()
}

class BaseCoordinator: Coordinator {
    var childCoordinators: [BaseCoordinator] = []

    func addToChildCoordinators(coordinator: Coordinator) {
        self.childCoordinators.append(coordinator as! BaseCoordinator)
    }

    func removeFromChildCoordinators(coordinator: BaseCoordinator) {
        if let index = childCoordinators.index(where: { return $0 == coordinator }) {
            self.childCoordinators.remove(at: index)
        }
    }

    func removeAllChildCoordinators() {
        self.childCoordinators.removeAll()
    }

    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        self.childCoordinators = childCoordinators.filter { $0 is T == false }
    }

    func start() {
        fatalError("Must override this function")
    }

    func finish() {
        fatalError("Must override this function")
    }
}

extension BaseCoordinator: Equatable {
    static func ==(lhs: BaseCoordinator, rhs: BaseCoordinator) -> Bool {
        return rhs === lhs
    }
}
