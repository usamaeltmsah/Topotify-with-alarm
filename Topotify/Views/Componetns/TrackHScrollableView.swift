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
    
    var onSelected: ((_ trackName: String) -> Void)?
//    @Binding var selectedTrackName: String
    
    
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
                                    let trackItem = TrackItem()
                                    trackItem.name = selectedTrack.name
                                    trackItem.author = selectedTrack.artists?.compactMap({$0.name}).joined(separator: ", ") ?? ""
                                    if let url = selectedTrack.uri {
                                        trackItem.url = url
                                    }
                                    
                                    if !trackItems.contains(trackItem) {
                                        $trackItems.append(trackItem)
                                        dismiss()
                                    }
                                    
//                                    selectedTrackName = item.element.name
//                                    onSelected?(selectedTrackName)
                                    
                                }
                        }
                    } //: LazyHGrid
                    .frame(height: 200)
                    .padding(.horizontal)
                }  //: ScrollView
            }
        }
    }
}


struct TrackHScrollableView_Previews: PreviewProvider {
    static var previews: some View {
        TrackHScrollableView(data: [.faces, .comeTogether, .reckoner, .odeToViceroy, .because, .theEnd], title: "Recent Played"/*, selectedTrackName: .constant("")*/)
            .previewLayout(.sizeThatFits)
    }
}

