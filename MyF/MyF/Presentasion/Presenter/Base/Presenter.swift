//
//  Presenter.swift
//  MyF
//
//  Created by macOS on 4/9/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation

protocol Presenter {
    associatedtype T
    
    func attach(_ view: T)
    
    func detach()
}
