//
//  ChooseMusicView.swift
//  Topotify
//
//  Created by Usama Fouad on 17/12/2022.
//

import SwiftUI
import UserNotifications
import RealmSwift

struct ChooseMusicView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isEditing: Bool = false
    @State private var isEmpty: Bool = true
    @State private var showSelectMusicView: Bool = false
    @State private var showAlarmActivatedView: Bool = false
    @AppStorage ("selectedTrackIndex") private var selectedTrackIndex: Int = 0
    @Binding var selectedTrack: TrackItem
    @State private var showScheduleAlarmView: Bool = false
    @Binding var dismissFromChooseMusicView: Bool
    
    @Binding var alarmTime: Date
    
    var onDismiss: ((_ trackName: String) -> Void)?
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
                                AddTrackListButton()
                            } //: label
                        } //: Section
                        .listRowBackground(trackItems.isEmpty ? .clear :  Color(.darkBlueColor))
                        ForEach(0..<trackItems.count, id: \.self) { index in
                            let trackItem = trackItems[index]
                            AlarmTrackView(trackName: trackItem.name, author: trackItem.author, isSelected: .constant(selectedTrackIndex == index))
                                .tag(trackItem.id)
                                .listRowInsets(.init(top: 0,leading: 0, bottom: 0, trailing: 0))
                                .contentShape(Rectangle())
                                .background(
                                    selectedTrackIndex == index ? Color(.lightBlueColor).opacity(0.2) : Color.clear
                                ) //: background
                                .onTapGesture {
                                    selectedTrackIndex = index
                                } //: onTapGesture
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
                        .onMove { IndexSet, offset in
                            print(offset)
                        }
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
                            EditButton()
                                .disabled(trackItems.isEmpty)
                                .foregroundColor(trackItems.isEmpty ? .gray : .white)
                        } //: ToolbarItem
                    } //: toolbar
                    NavigationLink(destination: SelectSpotifyMusicView(), isActive: $showSelectMusicView) {
                    }
                    
                    if !trackItems.isEmpty {
                        Button {
                            selectedTrack = trackItems[selectedTrackIndex]
                            hapticImpact.impactOccurred()
                            scheduleNotification(at: alarmTime, with: selectedTrack)
                            
                            presentationMode.wrappedValue.dismiss()
                            onDismiss?(trackItems[selectedTrackIndex].name)
                            
                            dismissFromChooseMusicView = true
                        } label: {
                            GradientButton(text: "Done")
                        } //: Label
                        .padding()
                    }
                    
                    Spacer()
                } //: VStack
            } //: NavigationView
        } //: GeometryReader
    }
    
    private func scheduleNotification(at: Date, with track: TrackItem) {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge]) { success, error in
            if success {
                showAlarmActivatedView = true
            } else if let error = error {
                print(error.localizedDescription)
            }
            
            let content = UNMutableNotificationContent()
            content.title = "It's \(alarmTime.getFormmatedTime(withA: true))"
            content.subtitle = "🎵 \(track.name)"
            //            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: ""))
            
            showNotification(at: alarmTime, with: content)
        }
    }
    
    private func showNotification(at time: Date, with content: UNMutableNotificationContent) {
        let notificationComponents = Calendar.current.dateComponents([.hour, .minute], from: time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: notificationComponents, repeats: false)
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
}

struct ShowMusicView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseMusicView(selectedTrack: .constant(TrackItem()), dismissFromChooseMusicView: .constant(false), alarmTime: .constant(Date()))
    }
}
