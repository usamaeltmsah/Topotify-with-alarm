//
//  SelectSpotifyMusicView.swift
//  Topotify
//
//  Created by Usama Fouad on 17/12/2022.
//


import SwiftUI
import Combine
import SpotifyWebAPI
import SpotifyExampleContent

struct SelectSpotifyMusicView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var spotify: Spotify
//    @Binding var selectedTrackName: String
    
    @State private var alert: AlertItem? = nil
    
    @State private var didRequestFirstPage = false
    
    @State private var searchCancellable: AnyCancellable? = nil
    
    @State private var searchText = ""
    
    @State var searchResults: SearchResult = SearchResult()
    
    @State private var recentlyPlayed: [Track] = []
    @State private var topTracks: [Track] = []
    
    @State private var loadRecentlyPlayedCancellable: AnyCancellable? = nil
    @State private var loadTopSongsCancellable: AnyCancellable? = nil
    @State var showModel = false

    var onDismiss: ((_ trackName: String) -> Void)?
    
    init() {
        self._searchResults = State(initialValue: SearchResult())
        self.recentlyPlayed = [Track]()
//        self.selectedtrackName = selectedtrackName
    }

    fileprivate init(searchResults: SearchResult, recentPlayed: [Track]) {
        self._searchResults = State(initialValue: searchResults)
        self._recentlyPlayed = State(initialValue: recentPlayed)
        self._topTracks = State(initialValue: recentPlayed)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                TrackHScrollableView(data: recentlyPlayed, title: "Recent Played"/*, selectedTrackName: $selectedTrackName*/)
                TrackHScrollableView(data: topTracks, title: "Your Songs"/*, selectedTrackName: $selectedTrackName*/)
                Spacer()
            } //: VStack
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) { // <3>
                    HStack {
                        Image(.spotifyLogoGreen)
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Spotify").font(.subheadline)
                    }  //: HStack
                } //: ToolbarItem
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("     ")
                } //: ToolbarItem
            } //: toolbar
            .foregroundColor(.white)
            .alert(item: $alert) { alert in
                Alert(title: alert.title, message: alert.message)
            } //: alert
            .onSubmit(of: .search) {
                search(q: searchText)
            } //: onSubmit
            .onAppear {
                if ProcessInfo.processInfo.isPreviewing {
                    return
                }
                
                if !self.didRequestFirstPage {
                    self.didRequestFirstPage = true
                    self.loadRecentlyPlayed()
                    self.loadTopSongs()
                }
            } //: onAppear
//            .onChange(of: $selectedTrackName) { newValue in
//                onDismiss?(newValue.wrappedValue)
//                presentationMode.wrappedValue.dismiss()
//            }
        } //: ScrollView
        .background(Color(.darkBlueColor))
    }
}

extension SelectSpotifyMusicView {
    func search(q: String) {
        self.searchResults = SearchResult()
        
        self.searchCancellable = self.spotify.api
            .search(query: q, categories: [.artist, .album, .track, .playlist])
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: self.receiveSpotifyDataCompletion(_:),
                receiveValue: { searchResults in
//                    let artists = searchResults.artists?.items.map({ $0.name })
                    self.searchResults = searchResults
                }
            )
    }
    
    func receiveSpotifyDataCompletion(_ completion: Subscribers.Completion<Error>) {
        if case .failure(let error) = completion {
            let title = "Couldn't retrieve spotify data"
            self.alert = AlertItem(
                title: title,
                message: error.localizedDescription
            )
        }
    }
}

extension SelectSpotifyMusicView {
    func loadRecentlyPlayed() {
        self.recentlyPlayed = []
        
        self.loadRecentlyPlayedCancellable = self.spotify.api
            .recentlyPlayed()
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: self.receiveSpotifyDataCompletion(_:),
                receiveValue: { playHistory in
                    let tracks = playHistory.items.map(\.track)
                    self.recentlyPlayed = tracks
                }
            )
    }
    
    func loadTopSongs() {
        self.topTracks = []
        
        self.loadTopSongsCancellable = self.spotify.api
            .currentUserTopTracks()
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: self.receiveSpotifyDataCompletion(_:),
                receiveValue: { songs in
                    let tracks = songs.items
                    self.topTracks = tracks
                }
            )
    }
}

struct SelectSpotifyMusicView_Previews: PreviewProvider {
    static let tracks: [Track] = [
        .illWind, .because, .comeTogether, .faces, .odeToViceroy, .reckoner
    ]
    
    static let artists: [Artist] = [
        .crumb, .levitationRoom, .pinkFloyd, .radiohead, .skinshape
    ]
    
    static var previews: some View {
        ForEach([tracks], id: \.self) { tracks in
            NavigationView {
//                SelectSpotifyMusicView(searchResults: SearchResult(), recentPlayed: tracks)
//                    .listStyle(PlainListStyle())
            }
        }
        .environmentObject(Spotify())
    }
}
