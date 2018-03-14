//
//  Array+Safe.swift
//  Drjoy
//
//  Created by Dr.JOY No,054 on 2017/07/07.
//  Copyright © 2017年 Dr.JOY No,054. All rights reserved.
//

import CocoaLumberjackSwift

extension Array {
    subscript (safe index: Int) -> Element? {
        get {
            return (0 <= index && index < count) ? self[index] : nil
        }
        set (value) {
            if value == nil {
                return
            }

            if !(count > index) {
                DDLogWarn("WARN: index:\(index) is out of range, so ignored. (array:\(self))")
                return
            }

            self[index] = value!
        }
    }
}
