//
//  TimeZoneExtensions.swift
//  Drjoy
//
//  Created by Manh Pham on 9/19/17.
//  Copyright © 2017 Dr.JOY No,054. All rights reserved.
//

import Foundation
extension TimeZone {
    /// get time zone string
    ///
    /// - Returns: +HH:mm
    static func timezone() -> String? {
        guard let timeZone =  TimeZone.current.abbreviation() else { return nil } // GMT+7
        let abbreviation = timeZone.substring(from: timeZone.index(timeZone.startIndex, offsetBy: 3))
        guard let abbreviationSign = abbreviation.firstCharacter else { return nil }
        let abbreviationNumber =  abbreviation.substring(from: abbreviation.index(abbreviation.startIndex, offsetBy: 1)).components(separatedBy: ":")
        
        let hour = abbreviationNumber[safe: 0] ?? "0"
        let minute = abbreviationNumber[safe: 1] ?? "0"
        return abbreviationSign + String.init(format: "%02d:%02d", Int(hour) ?? 0, Int(minute) ?? 0)
        
    }
}
