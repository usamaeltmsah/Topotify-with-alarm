//
//  TrackList.swift
//  Topotify
//
//  Created by Usama Fouad on 20/12/2022.
//

import Foundation
import RealmSwift

class TrackItem: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var trackId: String
    @Persisted var name: String
    @Persisted var videoId: String?
    @Persisted var url: String
    @Persisted var author: String
    @Persisted var video: Data?
    @Persisted var audio: Data?
    
    override class func primaryKey() -> String? {
        "id"
    }
}
