//
//  AlarmView.swift
//  Topotify
//
//  Created by Usama Fouad on 16/12/2022.
//

import SwiftUI

struct AlarmView: View {
    @State var time: Date = Date()
    @State var isSlidding: Bool = false
    @State private var showPicker: Bool = true
    @State private var showChooseMusicView: Bool = false
    
    @State var isDismissedFromChooseMusicView: Bool
    @State var trackItem: TrackItem = TrackItem()
    @State var authorName: String = ""
    var hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("alarm-background1")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(geometry.size, contentMode: .fill)
                
                if isDismissedFromChooseMusicView {
                    let hrs = Calendar.current.component(.hour, from: time)
                    let mins = Calendar.current.component(.minute, from: time)
                    if let newTime = Calendar.current.date(bySettingHour: hrs, minute: mins, second: 0, of: time) {
                        AlarmActivatedView(alarmScheduledAt: newTime,  track: trackItem, isDismissedFromChooseMusicView: $isDismissedFromChooseMusicView)
                    }
                }
                else {
                    VStack(alignment: .center) {
                        Spacer()
                        
                        DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            .frame(width: geometry.size.width / 1.5, height: 100)
                            .clipped()
                            .border(.gray, width: 2)
                            .cornerRadius(10)
                        
                        Spacer()
                        Spacer()
                        
                        VStack(alignment: .center, spacing: 1) {
                            Text("Wake up with your")
                            Text("favorite music")
                        } //: VStack
                        .font(.subheadline)
                        
                        Spacer()
                        
                        Button {
                            hapticImpact.impactOccurred()
                            showChooseMusicView.toggle()
                        } label: {
                            GradientButton(text: "Start")
                        } //: Label
                        .shadow(color: .white, radius: 35, x: 0, y: 0)
                        .sheet(isPresented: $showChooseMusicView) {
                            ChooseMusicView(selectedTrack: $trackItem, dismissFromChooseMusicView: $isDismissedFromChooseMusicView, alarmTime: $time)
                        }
                        Spacer()
                        Spacer()
                    } //: VStack
                    .showTabBar()
                    .foregroundColor(.white)
                    .offset(y: isSlidding ? 0 : 200)
                    .animation(.easeOut(duration: 0.5), value: isSlidding)
                }
            } //: ZStack
            
        } //: GeometryReader
        .onAppear {
            isSlidding = true
        }
    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView(isDismissedFromChooseMusicView: false)
    }
}
