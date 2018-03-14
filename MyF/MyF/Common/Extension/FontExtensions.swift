//
//  FontExtensions.swift
//  Drjoy
//
//  Created by Manh Pham on 8/30/17.
//  Copyright © 2017 Dr.JOY No,054. All rights reserved.
//

import Foundation
extension UIFont{
    class func systemFontW3(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "MotoyaLCedar-W3-90ms-RKSJ-H", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
    
    class func systemFontW6(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "MotoyaLCedar-W3-90ms-RKSJ-H", size: fontSize) ??  UIFont.boldSystemFont(ofSize:fontSize)
    }
}
