//
//  NSObject+Rx.swift
//  Utility
//
//  Created by aqu on 12/18/17.
//  Copyright © 2017 Unity Mac. All rights reserved.
//

import Foundation
import RxSwift

extension NSObject {
    private struct AssociatedKeys {
        static let DisposeBag = "rx_disposeBag"
    }
    
    private func doLock(block:()->Void){
        objc_sync_enter(self)
        
        defer {objc_sync_exit(self)}
        
        block()
    }
    
    var rx_disposeBag:DisposeBag {
        get{
            var bag : DisposeBag!
            doLock {
                if let lookup = objc_getAssociatedObject(self, AssociatedKeys.DisposeBag) as? DisposeBag {
                    bag = lookup
                } else {
                    let newBag = DisposeBag()
                    self.rx_disposeBag = newBag
                    bag = newBag
                }
            }
            return bag
        }
        
        set{
            objc_setAssociatedObject(self, AssociatedKeys.DisposeBag, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
    }
}


enum RepeatBehavior {
    case imediate(attems: Int)
    case delay(attems: Int , delay: Double)
    case ExponentialDelayed (initial: Double, multiplier: Double, maxDelay: Double)
    case CustomTimerDelayed (attempts: Int, delayCalculator:(Int) -> Double)
}

extension RepeatBehavior {
    func makeDelay(_ attemts: Int) -> TimeInterval{
        switch self {
        case .imediate(_):
            return 0.0
        case .delay(_, let delay):
            return TimeInterval(delay)
        case .ExponentialDelayed(let initial,let multiplier, let maxDelay):
            // if it's first attempt, simply use initial delay, otherwise calculate delay
            let delay = attemts == 1 ? initial : initial * pow(multiplier, Double(attemts - 1))
            print("delay \(min(maxDelay, delay)) at _ attemts \(attemts)")
            return min(maxDelay, delay)
        case .CustomTimerDelayed(_, let delayCalculator):
            return delayCalculator(attemts)
        }

    }
}

typealias RepeatPredicate = (Error) -> Bool

extension ObservableType {
    
    func retry(_ maxAttemts: Int = .max, repeatBehavior: RepeatBehavior, shouldRetry : RepeatPredicate? = nil, scheduleType: SchedulerType = MainScheduler.instance) -> Observable<E> {
        return self.retryWhen { (obserError) -> Observable<Void> in
            return obserError.enumerated().flatMap({ (attemts, error) -> Observable<Void> in
                guard shouldRetry?(error) == true , attemts <= maxAttemts else {return Observable.error(error)}
                
                return Observable<Int>.timer(RxTimeInterval(repeatBehavior.makeDelay(attemts)), scheduler: scheduleType).map({ (v) -> Void in
                    print("UtiLog: reply: \(attemts + 1) with delay \(repeatBehavior.makeDelay(attemts))")
                    return ()
                })
            })
        }
    }
}
