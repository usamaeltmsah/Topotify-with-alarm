//
//  ShowMusicView.swift
//  Topotify
//
//  Created by Usama Fouad on 17/12/2022.
//

import SwiftUI
import RealmSwift

struct ShowMusicView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isEditable: Bool = false
    @State private var isEmpty: Bool = true
    @State private var showSelectMusicView: Bool = false
    @AppStorage ("selectedTrackIndex") private var selectedTrackIndex: Int = 0
//    @State var newAddedTrackName: String = ""
    @State private var showScheduleAlarmView: Bool = false
    
    var hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    
    @ObservedResults(TrackItem.self) var trackItems
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack(alignment: .center, spacing: 1) {
                    if trackItems.isEmpty {
                        HelpView()
                    }
                    List {
                        Section {
                            Button {
                                showSelectMusicView.toggle()
                            } label: {
                                VStack {
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
                                } //: VStack
                                .frame(height: 70)
//                                .listRowBackground(Color.clear)
                            } //: label
                        } //: Section
                        .listRowBackground(trackItems.isEmpty ? .clear :  Color(.darkBlueColor))
                        ForEach(0..<trackItems.reversed().count, id: \.self) { index in
                            let trackItem = trackItems[index]
                            AlarmTrackView(trackName: trackItem.name, author: trackItem.author, isSelected: .constant(selectedTrackIndex == index))
                                .tag(trackItem.id)
                                .listRowInsets(.init(top: 0,leading: 0, bottom: 0, trailing: 0))
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    selectedTrackIndex = index
                                } //: onTapGesture
                                .background {
                                    selectedTrackIndex == index ? Color(.lightBlueColor).opacity(0.2) : Color(.darkBlueColor)
                                } //: background
                        } //: ForEach
                        .onDelete(perform: { indexSet in
                            print(selectedTrackIndex)
                            $trackItems.remove(atOffsets: indexSet)
                            for i in indexSet {
                                if selectedTrackIndex >= i && selectedTrackIndex > 0 {
                                    selectedTrackIndex -= 1
                                } else {
                                    selectedTrackIndex = 0
                                }
                            }
                        })
//                        ForEach(trackItems, id: \.id) { trackItem in
//                            AlarmTrackView(trackName: trackItem.name, author: trackItem.author, isSelected: false)
//                        }
                    } //: List
                    .listStyle(.plain)
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
                    NavigationLink(destination: SelectSpotifyMusicView(/*selectedTrackName: $newAddedTrackName*/), isActive: $showSelectMusicView) {
                    }
                    
                    Button {
                        hapticImpact.impactOccurred()
                        showScheduleAlarmView.toggle()
                    } label: {
                        GradientButton(text: "Done")
                    } //: Label
                    .opacity(trackItems.isEmpty ? 0 : 1)
                    .padding()
                    
                    Spacer()
                } //: VStack
                .background(Color(.darkBlueColor))
            } //: NavigationView
//            .onChange(of: $newAddedTrackName) { newValue in
//                let trackItem = TrackItem()
//                trackItem.name = newValue.wrappedValue
//
//                $trackItems.append(trackItem)
//            }
        } //: GeometryReader
    }
}

struct ShowMusicView_Previews: PreviewProvider {
    static var previews: some View {
        ShowMusicView()
    }
}
