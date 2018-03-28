//
//  RealmDao.swift
//  MyF
//
//  Created by macOS on 3/26/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDao<T: Object> {
    class func realmInit(){
        if let realmPath = Realm.Configuration.defaultConfiguration.fileURL?.path {
            print(realmPath)
        }
        
        let config = Realm.Configuration(schemaVersion:1, migrationBlock: { migration, oldSchemaVersion in
            if (oldSchemaVersion == 1) {
                
            }
        })
        Realm.Configuration.defaultConfiguration = config
    }
    
    func findAll(_ type: T.Type) throws -> Results<T>? {
        let realm = try Realm()
        return realm.objects(type)
    }
    
    func findById(_ type: T.Type, id: Any) throws -> T? {
        let realm = try Realm()
        return realm.object(ofType: type, forPrimaryKey: id)
    }
    
    func find(_ type: T.Type) throws -> T? {
        let realm = try Realm()
        return realm.objects(type).first
    }
    
    func create(_ val: T) throws {
        let realm = try Realm()
        try realm.write() {
            realm.add(val)
        }
    }
    
    func createOrUpdate(_ val: T) throws {
        let realm = try Realm()
        try realm.write() {
            realm.add(val, update: true)
        }
    }
    
    func delete() throws {
        let realm = try Realm()
        let realmObj = realm.objects(T.self)
        try realm.write() {
            realm.delete(realmObj)
        }
    }
}
