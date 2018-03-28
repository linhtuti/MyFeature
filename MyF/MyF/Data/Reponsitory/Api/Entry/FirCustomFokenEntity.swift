//
//  FirCustomFokenEntity.swift
//  MyF
//
//  Created by macOS on 3/27/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
import SwiftyJSON

class FirCustomFokenEntity: ApiResult {
    var token: String? = nil
    
    required init(_ val: NSDictionary) {
        super.init(val)
        
        self.token = JSON(val)[AppKey.TOKEN].string
    }
}
