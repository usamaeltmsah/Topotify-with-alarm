//
//  ShowMusicView.swift
//  Topotify
//
//  Created by Usama Fouad on 17/12/2022.
//

import SwiftUI

struct ShowMusicView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isEditable: Bool = false
    @State private var isEmpty: Bool = true
    @State private var showSelectMusicView: Bool = false
    @State var newAddedTrackName: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack(alignment: .leading, spacing: 1) {
                    if isEmpty {
                        HelpView()
                    }
                    List {
                        Section {
                            Button {
                                showSelectMusicView.toggle()
                            } label: {
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
                            } //: label
                        } //: Section
                        .frame(height: 70)
                        .listRowBackground(Color.white.opacity(0.1))
                    } //: List
                    .listStyle(.insetGrouped)
                    .navigationTitle("Choose Music")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarColor(backgroundColor: .clear, titleColor: .white)
                    .modifier(ListBackgroundModifier())
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Cancel") {
                                presentationMode.wrappedValue.dismiss()
                            }
                        } //: ToolbarItem
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Edit") {
                                print("Cancel tapped!")
                            }
                            .disabled(!isEditable)
                            .foregroundColor(isEditable ? .white : .gray)
                        } //: ToolbarItem
                    } //: toolbar
                    NavigationLink(destination: SelectSpotifyMusicView(selectedTrackName: $newAddedTrackName), isActive: $showSelectMusicView) {
                    }
                } //: VStack
                .background(Color(.darkBlueColor))
            } //: NavigationView
        } //: GeometryReader
    }
}

struct ShowMusicView_Previews: PreviewProvider {
    static var previews: some View {
        ShowMusicView(newAddedTrackName: "")
    }
}
