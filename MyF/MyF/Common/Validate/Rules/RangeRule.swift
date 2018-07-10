//
//  MaxRangeRule.swift
//  MyF
//
//  Created by macOS on 4/10/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation

enum RangeRuleType {
    case greater
    case less
    case equal
}

struct RangeRule: Rule {
    var length: Int = 0
    var type: RangeRuleType = .equal

    func validate(_ string: String) -> Bool {
        switch self.type {
        case .greater:
            return string.count >= length
        case .less:
            return string.count <= length
        case .equal:
            return string.count == length
        }
    }
}
