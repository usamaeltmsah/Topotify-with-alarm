//
//  TrackHScrollableView.swift
//  Topotify
//
//  Created by Usama Fouad on 19/12/2022.
//

import SwiftUI
import SpotifyWebAPI
import RealmSwift

struct TrackHScrollableView: View {
    @Environment(\.dismiss) var dismiss
    let data: Array<Track>
    let title: String
    @ObservedResults(TrackItem.self) var trackItems
    
    var body: some View {
        if !data.isEmpty {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .padding([.top, .horizontal], 10)
                    .font(.system(size: 25).bold())
                    .foregroundColor(Color(.lightBlueColor).opacity(0.5))
                
                ScrollView(.horizontal) {
                    LazyHGrid(rows: [GridItem(.flexible())]) {
                        ForEach(Array(data.enumerated()),
                                id: \.element.self) { item in
                            AlarmSpotifyGridView(name: item.element.name, details: item.element.artists?.compactMap({$0.name}).joined(separator: ", ") ?? "", spotifyImg: item.element.album?.images?.largest)
                                .onTapGesture {
                                    let selectedTrack = item.element
                                    
                                    if !trackItems.contains(where: {selectedTrack.id == $0.trackId}) {
                                        save(track: selectedTrack)
                                    }
                                    dismiss()
                                }
                        }
                    } //: LazyHGrid
                    .frame(height: 200)
                    .padding(.horizontal)
                }  //: ScrollView
            }
        }
    }
    
    private func save(track: Track) {
        let trackItem = TrackItem()
        trackItem.name = track.name
        trackItem.author = track.artists?.compactMap({$0.name}).joined(separator: ", ") ?? ""
        if let id = track.id { trackItem.trackId = id }
        if let url = track.uri { trackItem.url = url }
        $trackItems.append(trackItem)
    }
    
    private func update(track: Track) {
        do {
            let realm = try Realm()
            guard let objectToUpdate = realm.object(ofType: TrackItem.self, forPrimaryKey: track.id) else { return }
            try realm.write {
                objectToUpdate.name = track.name
//                objectToUpdate.index = sw
            }
        } catch {
            print(error)
        }
    }
}


struct TrackHScrollableView_Previews: PreviewProvider {
    static var previews: some View {
        TrackHScrollableView(data: [.faces, .comeTogether, .reckoner, .odeToViceroy, .because, .theEnd], title: "Recent Played"/*, selectedTrackName: .constant("")*/)
            .previewLayout(.sizeThatFits)
    }
}

