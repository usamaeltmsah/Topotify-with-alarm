import SwiftUI
import SpotifyWebAPI

struct RootView: View {
    @State private var alert: AlertItem? = nil
    @EnvironmentObject var spotify: Spotify
    
    var body: some View {
        if spotify.isAuthorized {
            EnterToAppView(alert: alert)
                .preferredColorScheme(.dark)
        } else {
            ShowLoginView()
        }
    }
    
}

struct RootView_Previews: PreviewProvider {
    
    static let spotify: Spotify = {
        let spotify = Spotify()
        spotify.isAuthorized = true
        return spotify
    }()
    
    static var previews: some View {
        RootView()
            .environmentObject(spotify)
    }
}
