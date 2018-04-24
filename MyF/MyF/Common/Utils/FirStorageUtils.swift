//
//  FirStorageUtils.swift
//  Drjoy
//
//  Created by Dr.JOY No,054 on 2017/09/15.
//  Copyright © 2017年 Dr.JOY No,054. All rights reserved.
//
import Foundation

class FirStorageUtils {
    
    static func iconName() -> String {
        return "icon.png"
    }
    
    static func groupFolder(_ groupId: String) -> String {
        return String(format: "group/%@/", groupId)
    }
    
    static func chatFolder(_ chatId: String) -> String {
        return String(format: "chat/%@/", chatId)
    }
}
