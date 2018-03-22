//
//  DataBaseQuery+Rx.swift
//  Utility
//
//  Created by aqu on 12/27/17.
//  Copyright © 2017 Unity Mac. All rights reserved.
//

import Foundation
import RxSwift

import Firebase

extension Reactive where Base: DatabaseQuery {
    ///listen whatever happen event change of locaton
    func observeEvent(event: DataEventType) -> Observable<DataSnapshot> {
        return Reactive.observeReachability().flatMap({ (_) -> Observable<DataSnapshot> in
            return self.base.rx.__observeChange(with: event)
        })
    }
    
    private func __observeChange(with eventType: DataEventType) -> Observable<DataSnapshot>{
        return Observable<DataSnapshot>.create({ (observable) -> Disposable in
            let handle = self.base.observe(eventType, with: { (dataSnapshot) in
                observable.onNext(dataSnapshot)
            })
            
            return Disposables.create{
                self.base.removeObserver(withHandle: handle)
            }
        })
    }
    
    
    ///listen data's change once time
    func observeSingleEvent(event: DataEventType) -> Observable<DataSnapshot> {
        return Reactive.observeReachability().flatMap({ (_) -> Observable<DataSnapshot> in
            return self.base.rx.__observeSingleEventOfType(eventType: event)
        })
    }
    
    private func __observeSingleEventOfType(eventType: DataEventType) -> Observable<DataSnapshot> {
        return Observable.create { observer in
            self.base.observeSingleEvent(of: eventType, with: { (snapshot) in
                observer.onNext(snapshot)
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
    
    /**
     * observeEventType:andPreviousSiblingKeyWithBlock: is used to listen for data changes at a particular location.
     * This is the primary way to read data from the Firebase Database. Your block will be triggered
     * for the initial data and again whenever the data changes. In addition, for FIRDataEventTypeChildAdded, FIRDataEventTypeChildMoved, and
     * FIRDataEventTypeChildChanged events, your block will be passed the key of the previous node by priority order.
     **/
    
    public func observerSubling(event: DataEventType) -> Observable<(DataSnapshot, String?)> {
        return Reactive.observeReachability().flatMap({ (_)  -> Observable<(DataSnapshot, String?)> in
            return self.__observerSubling(event: event)
        })
    }
    
    private func __observerSubling(event: DataEventType) -> Observable<(DataSnapshot, String?)> {
        return Observable<(DataSnapshot, String?)>.create { (observable) -> Disposable in
            let handle = self.base.observe(event, andPreviousSiblingKeyWith: { (dataSnapshot, keyPath) in
                observable.onNext((dataSnapshot, keyPath))
                observable.onCompleted()
            }, withCancel: { (error) in
                observable.onError(error)
            })
            return Disposables.create {
                self.base.removeObserver(withHandle: handle)
            }
        }
    }
    
    
    /**
     * This is equivalent to observeEventType:withBlock:, except the block is immediately canceled after the initial data is returned. In addition, for FIRDataEventTypeChildAdded, FIRDataEventTypeChildMoved, and
     * FIRDataEventTypeChildChanged events, your block will be passed the key of the previous node by priority order.
     *
     * The cancelBlock will be called if you do not have permission to read data at this location.
     **/
    
    public func observerSingleSubling(event: DataEventType) -> Observable<(DataSnapshot, String?)> {
        return Reactive.observeReachability().flatMap({ (_)  -> Observable<(DataSnapshot, String?)> in
            return self.__observerSingleSubling(event: event)
        })
    }
    
    private func __observerSingleSubling(event: DataEventType) -> Observable<(DataSnapshot, String?)> {
        return Observable<(DataSnapshot, String?)>.create { (observable) -> Disposable in
            self.base.observeSingleEvent(of: event, andPreviousSiblingKeyWith: { (dataSnapshot, keyPath) in
                observable.onNext((dataSnapshot, keyPath))
                observable.onCompleted()
            }, withCancel: { (error) in
                observable.onError(error)
            })
            
            return Disposables.create {
            }
        }
    }
    
    ///update data
    func updateData(_ values: [String: Any]) -> Observable<Void>? {
        return nil
    }
    
    static func observeReachability() -> Observable<Void> {
        let queryReachability = Database.database().reference(withPath: ".info/connected")
        return Observable.create({ (observable) -> Disposable in
            queryReachability.observeSingleEvent(of: DataEventType.value, with: { (dataSnapshot) in
                if let value = dataSnapshot.value as? Bool, value == true {
                    observable.onNext(())
                } else {
                    observable.onError(RxError.timeout)
                }
                
                observable.onCompleted()
            }, withCancel: { (error) in
                observable.onError(error)
            })
            
            return Disposables.create()
            
        }).retry(10, repeatBehavior: RepeatBehavior.delay(attems: 100, delay: 0.5), shouldRetry: { (error) -> Bool in
            if let _ = error as? RxError {
                return false
            }
            return true
        }, scheduleType: MainScheduler.instance)
    }
}
