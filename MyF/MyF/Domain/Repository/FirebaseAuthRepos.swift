//
//  FirebaseAuthRepos.swift
//  MyF
//
//  Created by macOS on 3/27/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
import RxSwift

protocol FirebaseAuthRepos {
    func getToken() -> Observable<FirCustomFokenEntity>
}
