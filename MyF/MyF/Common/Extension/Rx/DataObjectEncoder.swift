//
//  DataObjectEncode.swift
//  Utility
//
//  Created by aqu on 12/27/17.
//  Copyright © 2017 Unity Mac. All rights reserved.
//

import Foundation
import Firebase

protocol DataObjectEncoder {
    
    /// The key of the location that generated this FIRDataSnapshot.
    var firPath:String! {get}
    var firKey: String? { get set }
    init(snapshot: DataSnapshot)
}
