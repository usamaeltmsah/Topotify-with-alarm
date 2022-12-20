//
//  AddTrackListButton.swift
//  Topotify
//
//  Created by Usama Fouad on 20/12/2022.
//

import SwiftUI

struct AddTrackListButton: View {
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "plus")
                .padding(10)
                .background(Color(.lightBlueColor))
                .clipShape(Circle())
                .foregroundColor(Color(.darkBlueColor))
            
            Text("Add new")
                .foregroundColor(Color(.lightBlueColor))
            
            Spacer()
        } //: HStack
        .font(.bold(.title2)())
        .frame(height: 70)
    }
}


struct AddTrackListButton_Previews: PreviewProvider {
    static var previews: some View {
        AddTrackListButton()
    }
}
