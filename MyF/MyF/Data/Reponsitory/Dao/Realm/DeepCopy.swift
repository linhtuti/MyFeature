//
//  DeepCopy.swift
//  MyF
//
//  Created by macOS on 3/29/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation

protocol DeepCopy {
    associatedtype T
    
    func copyAlone() -> T
}
