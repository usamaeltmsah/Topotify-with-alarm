//
//  ShowLoginView.swift
//  Topotify
//
//  Created by Usama Fouad on 17/12/2022.
//

import SwiftUI
import Combine
import SpotifyWebAPI

struct ShowLoginView: View {
    @EnvironmentObject var spotify: Spotify
    @State var alert: AlertItem?
    @State private var cancellables: Set<AnyCancellable> = []
    var body: some View {
        TabView {
            LoginView()
        }
        .onOpenURL(perform: handleURL(_:))
    }
    
    func handleURL(_ url: URL) {
        guard url.scheme == self.spotify.loginCallbackURL.scheme else {
            self.alert = AlertItem(
                title: "Cannot Handle Redirect",
                message: "Unexpected URL"
            )
            return
        }
        
        spotify.isRetrievingTokens = true
        
        spotify.api.authorizationManager.requestAccessAndRefreshTokens(
            redirectURIWithQuery: url,
            state: spotify.authorizationState
        )
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
            
            self.spotify.isRetrievingTokens = false
            
            if case .failure(let error) = completion {
                let alertTitle: String
                let alertMessage: String
                if let authError = error as? SpotifyAuthorizationError,
                   authError.accessWasDenied {
                    alertTitle = "You Denied The Authorization Request :("
                    alertMessage = ""
                }
                else {
                    alertTitle =
                        "Couldn't Authorization With Your Account"
                    alertMessage = error.localizedDescription
                }
                self.alert = AlertItem(
                    title: alertTitle, message: alertMessage
                )
            }
        })
        .store(in: &cancellables)
        
        self.spotify.authorizationState = String.randomURLSafe(length: 128)
    }
}


struct ShowLoginView_Previews: PreviewProvider {
    static var previews: some View {
        ShowLoginView()
    }
}
