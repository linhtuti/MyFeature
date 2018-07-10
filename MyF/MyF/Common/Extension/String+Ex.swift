//
//  String+Ex.swift
//  MyF
//
//  Created by macOS on 4/26/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation

extension String {
    
    /**
     Subscript CountableClosedRange
     - Parameters:
     - bounds: bounds PartialRangeUpTo
     - Throwns:
     - Returns:
     - Substring PartialRangeUpTo "DEMO"[1...3] -> "EMO"
     */
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    
    /**
     Subscript CountablePartialRangeFrom
     - Parameters:
     - bounds: bounds PartialRangeUpTo
     - Throwns:
     - Returns:
     - Substring PartialRangeUpTo "DEMO"[2...] -> "MO"
     */
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    
    /**
     Subscript PartialRangeThrough
     - Parameters:
     - bounds: bounds PartialRangeUpTo
     - Throwns:
     - Returns:
     - Substring PartialRangeUpTo "DEMO"[...2] -> "DEM"
     */
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    
    /**
     Subscript PartialRangeUpTo
     - Parameters:
     - bounds: bounds PartialRangeUpTo
     - Throwns:
     - Returns:
     - Substring PartialRangeUpTo "DEMO"[..<2] -> "DE"
     */
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }

    func validation(with rule: Rule) -> Bool {
        return rule.validate(self)
    }
}
