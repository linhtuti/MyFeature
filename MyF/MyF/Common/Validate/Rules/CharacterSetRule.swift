//
//  CharacterSetRule.swift
//  MyF
//
//  Created by ntq on 5/9/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation

struct CharacterSetRule: Rule {
    let characterSet: CharacterSet

    func validate(_ string: String) -> Bool {
        for uni in string.unicodeScalars {
            guard let uniVal = UnicodeScalar(uni.value), characterSet.contains(uniVal) else {
                return false
            }
        }
        return true
    }
}
