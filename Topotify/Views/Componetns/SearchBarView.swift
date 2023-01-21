//
//  SearchBarView.swift
//  Topotify
//
//  Created by Usama Fouad on 21/01/2023.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor (
                    searchText.isEmpty ? Color.secondary : Color.white
                )
            TextField("Search by track name", text: $searchText)
                .foregroundColor (Color.white)
                .overlay(
                    Image (systemName: "xmark.circle.fill")
                        .padding ()
                        .offset(x: 10)
                        .foregroundColor (Color.white)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            searchText = ""
                        }
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding ()
        .background(
            RoundedRectangle (cornerRadius: 25)
                .fill(Color(.darkBlueColor))
                .shadow(color: Color.primary.opacity(0.15), radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
