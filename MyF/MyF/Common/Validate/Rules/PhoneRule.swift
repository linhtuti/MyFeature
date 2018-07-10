//
//  PhoneRule.swift
//  MyF
//
//  Created by macOS on 4/10/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation

struct PhoneRule: RegexRule {
    var regex: String {
        get { return "^\\d{10}$" }
    }
}
