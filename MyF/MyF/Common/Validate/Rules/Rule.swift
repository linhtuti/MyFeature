//
//  Rule.swift
//  MyF
//
//  Created by macOS on 4/10/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation

enum ValidError: Error {
    case PassWordInvalid
    case PhoneInvalid
}

public protocol Rule {
    func validate(_ string: String) -> Bool
}
