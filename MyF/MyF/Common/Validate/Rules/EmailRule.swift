//
//  EmailRule.swift
//  MyF
//
//  Created by macOS on 4/10/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation

struct EmailRule: RegexRule {
    var regex: String {
        get {
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        }
    }
}
