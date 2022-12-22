import SwiftUI
import Combine
import SpotifyWebAPI

@main
struct Topotify: App {

    @StateObject var spotify = Spotify()
    
//    let migrator = Migrator()
    
    init() {
        SpotifyAPILogHandler.bootstrap()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(spotify)
        }
    }
    
}
