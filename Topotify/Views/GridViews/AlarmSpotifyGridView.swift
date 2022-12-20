//
//  AlarmSpotifyGridView.swift
//  Topotify
//
//  Created by Usama Fouad on 19/12/2022.
//

import SwiftUI
import Combine
import SpotifyWebAPI

struct AlarmSpotifyGridView: View {
    @EnvironmentObject var spotify: Spotify
    
//    @State private var playRequestCancellable: AnyCancellable? = nil

    @State private var alert: AlertItem? = nil
    
    @State private var image = Image(.spotifyAlbumPlaceholder)

    @State private var didRequestImage = false
    
//    let track: Track
    
    let name: String
    let details: String
    let spotifyImg: SpotifyImage?
    
    // MARK: Cancellables
    @State private var loadImageCancellable: AnyCancellable? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay {
                    Color(.black)
                        .opacity(0.2)
                }
                .frame(width: 140, height: 150)
                .shadow(color: .secondary, radius: 2, x: 0, y: 0)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 1) {
                Text(name)
                    .font(.system(size: 15))
                
                Text(details)
                    .font(.system(size: 13).monospaced())
                    .foregroundColor(Color(.lightBlueColor))
            }
            .frame(width: 140, height: 30)
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        if self.didRequestImage {
            print("already requested image for '\(self)'")
            return
        }
        self.didRequestImage = true
        
        guard let spotifyImage = spotifyImg else {
            print("no image found for '\(self)'")
            return
        }
                
        self.loadImageCancellable = spotifyImage.load()
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { image in
                    print("received image for '\(name)'")
                    self.image = image
                }
            )
    }
}

struct AlarmSpotifyGridView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmSpotifyGridView(name: "Hello", details: "Ali, eds", spotifyImg: nil)
            .previewLayout(.sizeThatFits)
    }
}
