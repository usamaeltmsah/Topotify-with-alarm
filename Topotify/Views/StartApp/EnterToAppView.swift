//
//  EnterToApp.swift
//  Topotify
//
//  Created by Usama Fouad on 17/12/2022.
//

import SwiftUI

struct EnterToAppView: View {
    @State var alert: AlertItem?
    var body: some View {
        TabView {
            NavigationView {
                AlarmView()
            }
            .tabItem {
                Image(systemName: "alarm.waves.left.and.right")
                Text("Alarm")
            }
            NavigationView {
                TopSongsView()
            }
            .tabItem {
                Image("music-note")
                Text("Top Songs")
            }
            
            NavigationView {
                TopArtistsView()
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Top Artists")
            }
            
            NavigationView {
                RecentlyPlayedView()
            }
            .tabItem {
                Image(systemName: "clock.fill")
                Text("Recently Played")
            }
            
        }
        .navigationBarColor(backgroundColor: .clear, titleColor: UIColor(Color.primary))
        .alert(item: $alert) { alert in
            Alert(title: alert.title, message: alert.message)
        }
    }
}

struct EnterToApp_Previews: PreviewProvider {
    static var previews: some View {
        EnterToAppView()
    }
}
