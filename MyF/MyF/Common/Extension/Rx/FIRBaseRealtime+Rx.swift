//
//  FIRBaseRealtime+Rx.swift
//  Utility
//
//  Created by aqu on 12/22/17.
//  Copyright © 2017 Unity Mac. All rights reserved.
//

import Foundation
import RxSwift
import Firebase


extension Reactive where Base: DatabaseReference {
    func updatevalue(values: [String:AnyObject]) -> Observable<DatabaseReference> {
        return Observable<DatabaseReference>.create({ (observable) -> Disposable in
            self.base.updateChildValues(values) { (error, dataRef) in
                if error != nil {
                    observable.onError(error!)
                } else {
                    observable.onNext(dataRef)
                    observable.onCompleted()
                }
            }
            return Disposables.create()
        })
    }
    
    /// The same as setValue:andPriority: with a block that gets triggered after the write operation has
    /// been committed to the Firebase Database servers.
    ///    /// - Parameters:
    ///   - value: The value to be written
    ///   - priority: he Priority to be attached to the data.
    func setValue(value: AnyObject!, priority: AnyObject? = nil) -> Observable<DatabaseReference> {
        return Observable.create { observer in
            self.base.setValue(value, andPriority: priority, withCompletionBlock: { (error, databaseReference) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(databaseReference)
                    observer.onCompleted()
                }
            })
            
            
            return Disposables.create()
        }
    }
    
    /// The same as remove: with a block that gets triggered after the remove operation has
    /// been committed to the Firebase Database servers.
    ///
    func removeValue() -> Observable<DatabaseReference> {
        return Observable.create { observer in
            self.base.removeValue(completionBlock: { (error, databaseReference) in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(databaseReference)
                    observer.onCompleted()
                }
            })
            return Disposables.create()
        }
        
    }
    
   func runTransactionBlock(block: ((MutableData?) -> TransactionResult)!) -> Observable<(isCommitted: Bool, snapshot: DataSnapshot?)> {
        return Observable.create { observer in
            self.base.runTransactionBlock(block, andCompletionBlock: { (error, isCommitted, snapshot) in
            if let error = error {
                observer.onError(error)
            } else {
                observer.onNext((isCommitted, snapshot))
                observer.onCompleted()
                }
            })
            return Disposables.create()
        }
    }
}
