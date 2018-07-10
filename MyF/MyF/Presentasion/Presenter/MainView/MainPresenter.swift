//
//  MainPresenter.swift
//  MyF
//
//  Created by ntq on 5/28/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation

class MainPresenter: NSObject, Presenter {
    typealias V = MainView

    weak var view: MainView?

    var coordinator: MainCoordinator?

    init(_ coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }

    func attach<V>(_ view: V) where V : BaseView {
        self.view = view as? MainView
    }
}
