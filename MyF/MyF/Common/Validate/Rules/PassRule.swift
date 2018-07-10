//
//  PassRule.swift
//  MyF
//
//  Created by macOS on 4/10/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation

struct PassRule: RegexRule {
    var regex: String {
        return "^(?=.*?[a-z,A-Z]).{8,}$"
    }
}
