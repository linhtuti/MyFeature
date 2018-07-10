//
//  FloatRule.swift
//  MyF
//
//  Created by macOS on 4/10/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation

struct FloatRule: Rule {
    func validate(_ string: String) -> Bool {
        let regex = try? NSRegularExpression(pattern: "^[-+]?(\\d*[.])?\\d+$", options: [])
        if let regex = regex {
            let match = regex.numberOfMatches(in: string, options: [], range: NSRange(location: 0, length: string.count))
            return match == 1
        }
        return false
    }
}
