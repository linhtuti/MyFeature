//
//  AppInitializeManager.swift
//  MyF
//
//  Created by ntq on 3/22/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
import RxSwift
import Firebase

class AppInitializeManager {
    static let appInitializeManager = AppInitializeManager()
    lazy private var disposedBag = DisposeBag()

    fileprivate var initialized = false

    func prepare(_ application: UIApplication) {
        let listInit:[Task] = [RealmInit(),
                               FirInit()]

        var completed = 0
        var errorCnt = 0

        Observable<Bool>.create { observer in
            listInit.forEach({ (task) in
                task.run(observer: observer)
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
    func run(observer: AnyObserver<Bool>)
}

class RealmInit: Task{
    func run(observer: AnyObserver<Bool>) {
        RealmDao.realmInit()
        observer.onNext(true)
    }
}

class AppInitializeEventType: EventType {
    var isSuccess: Bool!
    init(success: Bool) {
        isSuccess = success
    }
}

class FirInit: Task {
    func run(observer: AnyObserver<Bool>) {
        if let path = Bundle.main.path(forResource: Const.PATH_GOOGLE_CONFIG, ofType: "plist"), let frBaseOption = FirebaseOptions.init(contentsOfFile: path) {
            FirebaseApp.configure(options: frBaseOption)
            
            observer.onNext(true)
        }
    }
}
