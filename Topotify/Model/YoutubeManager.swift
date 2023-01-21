//
//  YoutubeManager.swift
//  Topotify
//
//  Created by Usama Fouad on 31/12/2022.
//

import Foundation

struct YoutubeManager {
    private static let apiKey = "AIzaSyD0DYjvEtRUrJR8wd32U0WW4zHoR_XB8ag"
    private static let absuluteUrl = "https://www.googleapis.com/youtube/v3/"
    
    static func getYoutubeVideoId(with track: TrackItem) async -> String? {
        let searchUrl = "\(absuluteUrl)search?q=\(track.name.replacingOccurrences(of: " ", with: "%20"))-\(track.author)&key=\(apiKey)"
        guard let url = transformURLString(searchUrl)?.url else {
            return nil
        }
        
        var videoId: String?
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(YoutubeModel.self, from: data) {
                if let id = decodedResponse.items?.first?.id?.videoID {
                    videoId = id
                }
            }
        } catch {
            print("Invalid data")
        }
        
        return videoId
    }
    static func transformURLString(_ string: String) -> URLComponents? {
        guard let urlPath = string.components(separatedBy: "?").first else {
            return nil
        }
        var components = URLComponents(string: urlPath)
        if let queryString = string.components(separatedBy: "?").last {
            components?.queryItems = []
            let queryItems = queryString.components(separatedBy: "&")
            for queryItem in queryItems {
                guard let itemName = queryItem.components(separatedBy: "=").first,
                      let itemValue = queryItem.components(separatedBy: "=").last else {
                    continue
                }
                components?.queryItems?.append(URLQueryItem(name: itemName, value: itemValue))
            }
        }
        return components!
    }
    
    static func getVideoUrl(with track: TrackItem) async -> String {
        let id = await getYoutubeVideoId(with: track)
        return "https://www.youtube.com/watch?v=\(id ?? "Cm-LyRgTYe0")"
    }
}
