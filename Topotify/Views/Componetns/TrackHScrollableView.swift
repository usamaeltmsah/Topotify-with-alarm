//
//  TrackHScrollableView.swift
//  Topotify
//
//  Created by Usama Fouad on 19/12/2022.
//

import SwiftUI
import SpotifyWebAPI

struct TrackHScrollableView: View {
    let data: Array<Track>
    let title: String
    
    var body: some View {
        if !data.isEmpty {
            VStack(alignment: .leading, spacing: 20) {
                Text(title)
                    .padding(.horizontal, 10)
                    .font(.system(size: 25).bold())
                    .foregroundColor(Color(.lightBlueColor).opacity(0.5))
                
                ScrollView(.horizontal) {
                    LazyHGrid(rows: [GridItem(.flexible())]) {
                        ForEach(Array(data.enumerated()),
                                id: \.element.self) { item in
                            AlarmSpotifyGridView(name: item.element.name, details: item.element.artists?.compactMap({$0.name}).joined(separator: ", ") ?? "", spotifyImg: item.element.album?.images?.largest)
                                .onTapGesture {
                                    print(item.element.name)
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
        TrackHScrollableView(data: [.faces, .comeTogether, .reckoner, .odeToViceroy, .because, .theEnd], title: "Recent Played")
            .previewLayout(.sizeThatFits)
    }
}

