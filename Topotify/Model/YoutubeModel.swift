//
//  YoutubeModel.swift
//  Topotify
//
//  Created by Usama Fouad on 31/12/2022.
//

import Foundation

struct YoutubeModel {
    let items: [Item]?
}

// MARK: - Item
struct Item: Codable {
    let id: ID?
}

// MARK: - ID
struct ID: Codable {
    let videoID: String?

    enum CodingKeys: String, CodingKey {
        case videoID = "videoId"
    }
}
