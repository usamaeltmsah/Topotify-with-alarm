//
//  Migrator.swift
//  Topotify
//
//  Created by Usama Fouad on 20/12/2022.
//

import Foundation
import RealmSwift
class Migrator {
    init() {
        updateSchema()
    }
    
    func updateSchema() {
        let config = Realm.Configuration(schemaVersion: 1) { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                // add new fields
                migration.enumerateObjects(ofType: TrackItem.className()) { _, newobject in
//                        newobject!["items"] = List<TrackItem>()
                    migration.deleteData(forType: "isSelected")
                    newobject!["trackId"] = ""
                }
            }
            Realm.Configuration.defaultConfiguration = config
            let _ = try! Realm()
        }
    }
}
