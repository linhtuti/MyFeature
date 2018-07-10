//
//  Presenter.swift
//  MyF
//
//  Created by macOS on 4/9/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation

protocol Presenter: class {
    associatedtype V

    var view: V? { get set }
    
    func attach<V: BaseView>(_ view: V)
    
    func detach()
}


extension Presenter {
    func detach() {
        view = nil
    }
}
