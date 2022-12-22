import SwiftUI
import Combine
import SpotifyWebAPI

@main
struct Topotify: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
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
