//
//  AlarmTrackView.swift
//  Topotify
//
//  Created by Usama Fouad on 20/12/2022.
//

import SwiftUI

struct AlarmTrackView: View {
    var trackName: String
    var author: String
    @Binding var isSelected: Bool
    
    let SpotifyImageSize = 35.0
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .strokeBorder(.white, lineWidth: 3)
                    .frame(width: SpotifyImageSize + 10)
                    .opacity(isSelected ? 1 : 0)
                
                Image(.spotifyLogoGreen)
                    .resizable()
                    .frame(width: SpotifyImageSize, height: SpotifyImageSize)
                    .clipShape(Circle())
            }
            
            
            VStack(alignment: .leading) {
                Text(trackName)
                    .font(.headline)
                Text(author)
                    .font(.callout)
                    .foregroundColor(Color(.lightBlueColor))
            }
            
            Spacer()
            
            Button {
                //
            } label: {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 25))
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .frame(height: 80)
    }
}

struct AlarmTrackView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmTrackView(trackName: "Ramadan Gana", author: "Maher Zain", isSelected: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
