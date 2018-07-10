//
//  FirCustomTokenEntity.swift
//  MyF
//
//  Created by ntq on 5/15/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
import SwiftyJSON

class FirCustomTokenEntity: ApiResult {
    var tokenAuth: String?

    required init(_ val: NSDictionary) {
        super.init(val)
        let _ = JSON(val)

        self.tokenAuth = ""
    }
}
