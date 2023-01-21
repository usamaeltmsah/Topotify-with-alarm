//
//  AlarmActivatedView.swift
//  Topotify
//
//  Created by Usama Fouad on 22/12/2022.
//

import SwiftUI
import AVKit
import XCDYouTubeKit
import YoutubeKit
import BackgroundTasks
import RealmSwift

struct AlarmActivatedView: View {
    @State var alarmScheduledAt: Date
    @State var track: TrackItem
    @State private var currentTime: String = ""
    @State private var remainingTime: String = ""
    @State private var isSlidding: Bool = false
    @State private var isScheduled: Bool = false
    @Binding var isDismissedFromChooseMusicView: Bool
    @State var id: String?
    @State var isAlarmTriggered: Bool = false
    //    @State var idLoaded: Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .center) {
            
            if let id {
                AlarmStartedView(videoId: id, alarmScheduledAt: alarmScheduledAt, isAlarmTriggered: $isAlarmTriggered, isDismissedFromChooseMusicView: $isDismissedFromChooseMusicView)
            }
            if !isAlarmTriggered {
                Text("Alarm activated, please lock the phone")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(
                        Color.secondary.opacity(0.2)
                    )
                    .foregroundColor(Color.white)
                    .cornerRadius(15)
                    .padding()
                    .offset(y: isScheduled ? 0 : -200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
                
                VStack(spacing: 10) {
                    Text(currentTime)
                        .font(.system(.largeTitle, design: .rounded).bold())
                    VStack(spacing: 1) {
                        Text("Alarm \(alarmScheduledAt.getFormmatedTime(withA: true)) . \(remainingTime)".lowercased())
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.semibold)
                        
                        HStack(spacing: 2) {
                            Text("with")
                                .fontWeight(.medium)
                            Text("\(track.name)")
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .lineLimit(3)
                        }
                        .font(.title3)
                        .foregroundColor(Color(.lightBlueColor))
                    }
                }
                Spacer()
                
                SliderButton(text: "Stop Alarm", buttonColor: .yellow, isSlidding: $isSlidding, color: .white, isDismissedFromChooseMusicView: $isDismissedFromChooseMusicView)
                    .frame(height: 100)
                    .padding()
                Spacer()
            }
        }
        .offset(y: isSlidding ? 0 : -1000)
        .animation(.easeInOut(duration: 0.3), value: isSlidding)
        .onAppear {
            Task {
                guard let savedId = track.videoId else {
                    id = await YoutubeManager.getYoutubeVideoId(with: track)
                    if let id {
                        updateTrack(with: id)
                    } else {
                        id = "Cm-LyRgTYe0"
                    }
                    return
                }
                
                id = savedId
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                isSlidding = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                withAnimation {
                    isScheduled = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now()+4.5) {
                withAnimation {
                    isScheduled = false
                }
            }
        }
        .onReceive(timer) { _ in
            changeDatesValues()
        }
    }
    
    private func updateTrack(with id: String) {
        let realm = try! Realm()
        if let trackItem = realm.objects(TrackItem.self).first {
            try! realm.write{
                trackItem.videoId = id
            }
        }
    }
    
    private func changeDatesValues() {
        self.currentTime = Date().getFormmatedTime()
        self.remainingTime = alarmScheduledAt.getFormattedRemainingTimeFromNow()
    }
}

struct AlarmActivatedView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmActivatedView(alarmScheduledAt: Date(), track: TrackItem(), isDismissedFromChooseMusicView: .constant(false))
    }
}
