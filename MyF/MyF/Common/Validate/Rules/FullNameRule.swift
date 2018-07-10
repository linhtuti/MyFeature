//
//  FullNameRule.swift
//  MyF
//
//  Created by ntq on 5/9/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation

struct FullNameRule: Rule {
    func validate(_ string: String) -> Bool {
        let nameArray: [String] = string.split { $0 == " " }.map { String($0) }
        return nameArray.count >= 2
    }
}
