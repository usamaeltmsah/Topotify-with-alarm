//
//  AlarmActivatedView.swift
//  Topotify
//
//  Created by Usama Fouad on 22/12/2022.
//

import SwiftUI

struct AlarmActivatedView: View {
    @State var alarmScheduledAt: Date
    @State var trackName: String
    @State private var currentTime: String = ""
    @State private var remainingTime: String = ""
    @State private var isSlidding: Bool = false
    @State private var isScheduled: Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .center) {
            
            Text("Alarm activated, please lock the phone")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
                .background(.ultraThickMaterial)
                .foregroundColor(.white)
                .cornerRadius(15)
                .padding()
                .offset(y: isScheduled ? 0 : -200)
                .transition(.asymmetric(insertion: .scale, removal: .opacity))
            
            Text(currentTime)
                .font(.system(.largeTitle, design: .rounded).bold())
            
            Spacer()
            
            Text("Alarm \(alarmScheduledAt.getFormmatedTime(withA: true)) . \(remainingTime)".lowercased())
                .font(.system(.title, design: .rounded))
                .fontWeight(.semibold)
            
            HStack(spacing: 2) {
                Text("with")
                    .fontWeight(.medium)
                Text("\(trackName)")
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
            }
            .font(.title3)
            .foregroundColor(Color(.lightBlueColor))
            
            Spacer()
            
            StopAlarmView(text: "Stop Alarm", buttonColor: .yellow, color: .white)
                .frame(height: 100)
                .padding()
        }
        .offset(y: isSlidding ? 0 : -1000)
        .animation(.easeOut(duration: 0.3), value: isSlidding)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                isSlidding = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                withAnimation {
                    isScheduled = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now()+6) {
                withAnimation {
                    isScheduled.toggle()
                }
            }
        }
        .onReceive(timer) { _ in
            changeDatesValues()
        }
    }
    
    private func changeDatesValues() {
        self.currentTime = Date().getFormmatedTime()
        self.remainingTime = alarmScheduledAt.getFormattedRemainingTimeFromNow()
    }
}

struct AlarmActivatedView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmActivatedView(alarmScheduledAt: Date(), trackName: "Ramadan Kareem")
    }
}
