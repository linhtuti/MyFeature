//
//  BasePreseter.swift
//  MyF
//
//  Created by macOS on 4/9/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation

class BasePresenter: Presenter {
    typealias T = BaseVC
    
    var view: T!
    
    func attach(_ view: BasePresenter.T) {
        self.view = view
    }
    
    func detach() {
        self.view = nil
    }
}
