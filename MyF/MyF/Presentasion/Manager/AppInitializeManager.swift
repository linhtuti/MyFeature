//
//  AppInitializeManager.swift
//  MyF
//
//  Created by ntq on 3/22/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
import RxSwift
import CocoaLumberjack

class AppInitializeManager {
    static let appInitializeManager = AppInitializeManager()
    lazy private var disposedBag = DisposeBag()

    fileprivate var initialized = false

    func prepare(_ application: UIApplication) {
        let listInit:[Task] = [DDLogInit()]

        var completed = 0
        var errorCnt = 0

        Observable<Bool>.create { observer in
            listInit.forEach({ (task) in
                task.run(obsever: observer)
            })

            return Disposables.create()
            }.subscribe { done in
                if !done.isCompleted {
                    errorCnt += 1
                }

                completed += 1
                if completed == listInit.count {
                    EventHub.post(AppInitializeEventType.init(success: true))
                }
            }.disposed(by: disposedBag)
    }
}


protocol Task {
    func run(obsever: AnyObserver<Bool>)
}

class DDLogInit: Task {
    func run(obsever: AnyObserver<Bool>) {
        #if DEBUG
            DDLog.add(DDTTYLogger.sharedInstance, with: .debug)
        #else
            DDLog.add(DDTTYLogger.sharedInstance, with: .error)
        #endif
        obsever.onNext(true)
    }
}

class AppInitializeEventType: EventType {
    var isSuccess: Bool!
    init(success: Bool) {
        isSuccess = success
    }
}
