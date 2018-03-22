//
//  EventHub.swift
//  MyF
//
//  Created by ntq on 3/22/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation

public protocol EventType {}

public enum Thread {
    case main
    case background(queue: DispatchQueue?)

    var queue:DispatchQueue {
        switch self {
        case .main:
            return DispatchQueue.main
        case .background(let queue):
            guard let _queue = queue else {
                return DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
            }
            return _queue
        }
    }
}

public struct Observation {
    weak var observer: AnyObject?
    var thread: Thread?
    let block: Any?
}

// Add synchonize of stuff
public struct EventHub {
    public static var observations: [Observation] = []
    private static let lock = UUID.init() as Any

    public static func addObservation<T: EventType>(observer: AnyObject?, thread: Thread, block: (T) -> Void) {
        sync {
            observations.append(Observation.init(observer: observer, thread: thread, block: block))
        }
    }

    public static func removeObservation(observer: AnyObject) {
        sync {
            observations = observations.filter({return $0.observer! !== observer})
        }
    }

    public static func post<T: EventType>(_ event: T) {
        observations = observations.filter({return $0.observer != nil})

        observations.forEach { observer in
            if let block = observer.block as? ((T)->Void) {
                if let thread = observer.thread?.queue {
                    thread.sync {
                        block(event)
                    }
                } else {
                    block(event)
                }
            }
        }
    }

    static func sync(block: ()->Void) {
        objc_sync_enter(lock)
        block()
        objc_sync_exit(lock)
    }
}
