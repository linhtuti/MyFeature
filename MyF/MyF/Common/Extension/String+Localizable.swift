//
//  String+Localizable.swift
//  Drjoy
//
//  Created by Dr.JOY No,054 on 2017/07/07.
//  Copyright © 2017年 Dr.JOY No,054. All rights reserved.
//

extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
