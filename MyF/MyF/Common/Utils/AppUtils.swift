//
//  AppUtils.swift
//  Drjoy
//
//  Created by Dr.JOY No,054 on 2017/07/05.
//  Copyright © 2017年 Dr.JOY No,054. All rights reserved.
//

import CocoaLumberjack

class AppUtils {
    
    static func apiUrl() -> String {
        //return FIRRemoteConfig.remoteConfig().configValue(forKey: "api_url").stringValue!
        return ""
    }
}


func DLOG(_ message: String) {
    #if DEBUG
        DDLogDebug(message)
    #endif
}
