//
//  ApiResult.swift
//  MyF
//
//  Created by macOS on 3/25/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
protocol _OptionalProtocol {
    // the metatype value for the wrapped type.
    static var wrappedType: Any.Type { get }
}

extension Optional : _OptionalProtocol {
    static var wrappedType: Any.Type { return Wrapped.self }
}

protocol Encodable{
    init(_ val: NSDictionary)
}

protocol Decodable{
    
}
extension Decodable {
    func toDictionary() throws -> NSDictionary {
        return try JSONUtils.toDictionary(self)
    }
}

class ApiResult : Encodable, Decodable{
    required init(_ val: NSDictionary) {
        
    }
}
