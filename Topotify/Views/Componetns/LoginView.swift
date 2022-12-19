//
//  Login.swift
//  Topotify
//
//  Created by Usama Fouad on 30/07/2022.
//

import SwiftUI

struct LoginView: View {
    fileprivate static var debugAlwaysShowing = false
    static let animation = Animation.spring()
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var spotify: Spotify
    
    @State private var finishedViewLoadDelay = false
    
    let backgroundGradient = LinearGradient(
        gradient: Gradient(
            colors: [Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), Color(#colorLiteral(red: 0.1903857588, green: 0.8321116255, blue: 0.4365008013, alpha: 1))]
        ),
        startPoint: .leading, endPoint: .trailing
    )

    var spotifyLogo: ImageName {
        colorScheme == .dark ? .spotifyLogoWhite
                : .spotifyLogoBlack
    }
    
    var body: some View {
        ZStack {
            if !spotify.isAuthorized || Self.debugAlwaysShowing {
                Color.black.opacity(0.25)
                    .edgesIgnoringSafeArea(.all)
                if self.finishedViewLoadDelay || Self.debugAlwaysShowing {
                    loginView
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(LoginView.animation) {
                    self.finishedViewLoadDelay = true
                }
            }
        }
    }
    
    var loginView: some View {
        spotifyButton
            .padding()
            .padding(.vertical, 50)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(20)
            .overlay(retrievingTokensView)
            .shadow(radius: 5)
            .transition(
                AnyTransition.scale(scale: 1.2)
                    .combined(with: .opacity)
            )
    }

    var spotifyButton: some View {

        Button(action: spotify.authorize) {
            HStack {
                Image(spotifyLogo)
                    .interpolation(.high)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 40)
                Text("Log in with Spotify")
                    .font(.title)
            }
            .padding()
            .background(backgroundGradient)
            .clipShape(Capsule())
            .shadow(radius: 5)
        }
        .accessibility(identifier: "Log in with Spotify Identifier")
        .buttonStyle(PlainButtonStyle())
        // Prevent the user from trying to login again
        // if a request to retrieve the access and refresh
        // tokens is currently in progress.
        .allowsHitTesting(!spotify.isRetrievingTokens)
        .padding(.bottom, 5)

    }

    var retrievingTokensView: some View {
        VStack {
            Spacer()
            if spotify.isRetrievingTokens {
                HStack {
                    ProgressView()
                        .padding()
                    Text("Authenticating")
                }
                .padding(.bottom, 20)
            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static let spotify = Spotify()
    
    static var previews: some View {
        LoginView()
    }
    
    static func onAppear() {
        spotify.isAuthorized = false
        spotify.isRetrievingTokens = true
        LoginView.debugAlwaysShowing = true
    }
}
