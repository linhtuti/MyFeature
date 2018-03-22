//
//  FIRBaseModel.swift
//  Utility
//
//  Created by aqu on 12/27/17.
//  Copyright © 2017 Unity Mac. All rights reserved.
//

import Foundation
import Firebase
import RxSwift

class FIRBaseModel {
    
    /// Listen for data changes at a particular location.
    final func observe<T: DataObjectEncoder>(eventType: DataEventType) -> Observable<T> {
        return Observable.deferred {
            return self.firQuery().rx.observeEvent(event: eventType).map(T.init)
        }
    }
    
    
    /// Listen for data once time at a particular location.
    final func observeSingleEvent<T: DataObjectEncoder>(eventType: DataEventType) -> Observable<T> {
        return Observable.deferred({ () -> Observable<T> in
            return self.firQuery().rx.observeSingleEvent(event: eventType).map(T.init)
        })
    }
    
//    final func updateChildValue(values: [String: Any]) -> Observable<Void>{
//        return Observable.deferred({ () -> Observable<Void> in
//
//        })
//    }
//
    func firRefrenceLocation() -> DatabaseReference {
        rxAbstractMethod()
    }
    
    func firQuery() -> DatabaseQuery {
        rxAbstractMethod()
    }

}


func rxAbstractMethod(withMessage message:String = "Abtract method not implement", file: String = #function, line: Int64 = #line) -> Swift.Never {
    rxFatalError(message: message, file: file, line: line)
}

func rxFatalError(message: @autoclosure ()->String, file: String = #function, line: Int64 = #line) -> Swift.Never {
    fatalError("\(message()) - file \(file) - line \(line)")
}

