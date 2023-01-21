//
//  YoutubePlayerView.swift
//  Topotify
//
//  Created by Usama Fouad on 31/12/2022.
//

import SwiftUI
import AVKit
import XCDYouTubeKit
import Combine
import RealmSwift

struct AlarmStartedView: View {
    @State var videoId: String
    @State var videoUrl: URL? = nil
    @State var player: AVPlayer?
    @State var alarmScheduledAt: Date
    @State var isSlidding: Bool = false
    @Binding var isAlarmTriggered: Bool
    @Binding var isDismissedFromChooseMusicView: Bool
    @State var currentTime: String = ""
    @State var currentDate: String = ""
    
    @ObservedResults(TrackItem.self) var trackItems
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(videoId: String, alarmScheduledAt: Date, isAlarmTriggered: Binding<Bool>, isDismissedFromChooseMusicView: Binding<Bool>) {
        self._videoId = .init(initialValue: videoId)
        self._alarmScheduledAt = .init(initialValue: alarmScheduledAt)
        self._isAlarmTriggered = isAlarmTriggered
        self._isDismissedFromChooseMusicView = isDismissedFromChooseMusicView
    }
    
    var body: some View {
        VStack {
            if isAlarmTriggered {
                //            if alarmScheduledAt.timeIntervalSinceNow <= 0 {
                
                VStack {
                    Spacer()
                    Text(currentTime)
                        .font(.system(.largeTitle, design: .rounded).bold())
                    Text(currentDate)
                        .font(.system(.footnote, design: .rounded).bold())
                    ZStack {
                        Color.white
                            .opacity(0.25)
                        
                        VideoPlayer(player: player)
                        //            AVPlayerView(videoURL: $videoUrl)
                            .frame(width: 300, height: 150)
                            .cornerRadius(30)
                    }
                    .frame(width: 320, height: 170)
                    .cornerRadius(30)
                    
                    Spacer()
                    
                    SliderButton(text: "Wake Up", buttonColor: .orange, isSlidding: $isSlidding, isDismissedFromChooseMusicView: $isDismissedFromChooseMusicView)
                        .frame(height: 100)
                        .padding()
                    
                    Spacer()
                }
                .offset(x: isSlidding ? 0 : -500)
                .animation(.easeInOut(duration: 0.3), value: isSlidding)
                .onAppear {
                    isSlidding = true
                }
            } else {
                Spacer()
                    .frame(height: 0)
            }
        }
        .hiddenTabBar()
        .onAppear {
            configureAudio()
            getVideo()
        }
        .onDisappear {
            stopPlayer()
        }
        .onReceive(timer) { _ in
            changeDatesValues()
        }
    }
    
    private func changeDatesValues() {
        self.currentTime = Date().getFormmatedTime()
        self.currentDate = Date().getFormmatedDate()
    }
    
    private func configureAudio() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func getVideo() {
        XCDYouTubeClient.default().getVideoWithIdentifier(videoId) { [self] video, error in
            if let video {
                let playerViewController = AVPlayerViewControllerManager.shared.controller
                guard let url = video.streamURL else { return }
                playerViewController.player = AVPlayer(url: url)
                playerViewController.player?.automaticallyWaitsToMinimizeStalling = false
                playerViewController.player?.volume = 1.0
                self.player = playerViewController.player
                self.player?.audiovisualBackgroundPlaybackPolicy = .continuesIfPossible
                AVPlayerViewControllerManager.shared.player = self.player
                let timer = Timer(timeInterval: alarmScheduledAt.getRemaingTimeFromNow(), repeats: false) { timer in
                    isAlarmTriggered = true
                    self.player?.play()
                }

                RunLoop.current.add(timer, forMode: .common)
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    private func stopPlayer() {
        self.player?.pause()
        AVPlayerViewControllerManager.shared.controller.player?.pause()
        self.player = nil
        AVPlayerViewControllerManager.shared.controller.player = nil
    }
}

struct YoutubePlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmStartedView(videoId: "YE7VzlLtp-4", alarmScheduledAt: .now, isAlarmTriggered: .constant(false), isDismissedFromChooseMusicView: .constant(false))
    }
}
