//
//  StopAlarmView.swift
//  Topotify
//
//  Created by Usama Fouad on 19/12/2022.
//

import SwiftUI

struct StopAlarmView: View {
    var color: Color = .black
    @State private var buttonOffset = CGSize.zero
    let buttonWidth: CGFloat = 75
    
    let feedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Capsule()
                    .fill(color.opacity(0.2))
                    .frame(height: 100)
                
                Capsule()
                    .fill(color.opacity(0.4))
                    .frame(height: 80)
                    .padding(10)
                
                Text("Stop Alarm")
                    .font(.system(size: 30, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.yellow)
                    .opacity(abs(buttonOffset.width) > 0 ? 0 : 1 )
                
                HStack {
                    Capsule()
                        .fill(.yellow)
                        .frame(width: buttonWidth + buttonOffset.width, height: buttonWidth)
                        .padding()
                    
                    Spacer()
                }
                
                HStack {
                    ZStack {
                        Circle()
                            .fill(.yellow)
                        
                        Circle()
                            .fill(.black.opacity(0.2))
                            .padding(8)
                        
                        Image(systemName: "chevron.right.2")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                        
                    }
                    .frame(width: buttonWidth, alignment: .leading)
//                    .padding(15)
                    
                    Spacer()
                }
                .padding(15)
                .offset(x: buttonOffset.width)
                .gesture(DragGesture()
                    .onChanged({ gesture in
                        if (gesture.translation.width <= geometry.size.width - (buttonWidth + 60) && gesture.translation.width >= 0) {
                            buttonOffset = gesture.translation
                        }
                    })
                    .onEnded({ _ in
                        withAnimation(.easeOut(duration: 0.5)) {
                            if (buttonOffset.width <= geometry.size.width - (buttonWidth + 70)) {
                                buttonOffset = .zero
                                feedback.notificationOccurred(.error)
                            } else {
                                
                                feedback.notificationOccurred(.error)
                            }
                        }
                    })
                )
            }
            .padding(10)
        }
    }
}

struct StopAlarmView_Previews: PreviewProvider {
    static var previews: some View {
        StopAlarmView()
            .previewLayout(PreviewLayout.sizeThatFits)
        
    }
}

