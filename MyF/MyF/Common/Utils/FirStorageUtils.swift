//
//  FirStorageUtils.swift
//  Drjoy
//
//  Created by Dr.JOY No,054 on 2017/09/15.
//  Copyright © 2017年 Dr.JOY No,054. All rights reserved.
//

import CryptoSwift

class FirStorageUtils {
    
    static func iconName() -> String {
        return "icon.png"
    }
    
    static func genGroupFileId(_ groupId: String, _ contentsId: String) -> String {
        let unixtime: String = String("\(Date().timeIntervalSince1970)")
        return String(format: "%@%@%@", groupId, contentsId, unixtime).sha256()
    }
    
    static func genChatFileId(_ chatId: String) -> String {
        let unixtime: String = String("\(Date().timeIntervalSince1970)")
        return String(format: "%@%@", chatId, unixtime).sha256()
    }
    
    static func userFolder(_ userId: String, _ officeId: String) -> String{
        return String(format: "img/staff/face/%@/%@/", officeId, userId.sha256())
    }
    
    static func groupFolder(_ groupId: String) -> String {
        return String(format: "group/%@/", groupId)
    }
    
    static func chatFolder(_ chatId: String) -> String {
        return String(format: "chat/%@/", chatId)
    }
    
    static func userIconPath(userId: String, officeId: String) -> String{
        return userFolder(userId, officeId) + iconName()
    }
    
    static func groupIconPath(groupId: String) -> String {
        return groupFolder(groupId) + iconName()
    }
    
    static func groupAttachedFilePath(groupId: String, fileId: String) -> String {
        return groupFolder(groupId) + fileId
    }
    
    static func chatIconPath(chatId: String) -> String {
        return chatFolder(chatId) + iconName()
    }
    
    static func chatAttachedFilePath(chatId: String, fileId: String) -> String {
        return chatFolder(chatId) + fileId
    }

}
