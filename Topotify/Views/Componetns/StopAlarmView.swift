//
//  StopAlarmView.swift
//  Topotify
//
//  Created by Usama Fouad on 19/12/2022.
//

import SwiftUI

struct StopAlarmView: View {
    
    @State var text: String
    @State var buttonColor: Color
    
    var color: Color = .white
    @State private var buttonOffset = CGSize.zero
    let buttonWidth: CGFloat = 75
    
    let feedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Capsule()
                    .fill(color.opacity(0.2))
                
                Capsule()
                    .fill(color)
                    .frame(height: 85)
                    .padding(10)
                
                Text("Stop Alarm")
                    .font(.system(size: 30, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(buttonColor)
                    .opacity(abs(buttonOffset.width) > 0 ? 0 : 1 )
                
                HStack {
                    Capsule()
                        .fill(buttonColor)
                        .frame(width: buttonWidth + buttonOffset.width, height: buttonWidth)
                        .padding()
                    
                    Spacer()
                }
                
                HStack {
                    ZStack {
                        Circle()
                            .fill(buttonColor)
                        
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
                            if (buttonOffset.width <= geometry.size.width / 2 - (buttonWidth)) {
                                buttonOffset = .zero
                                feedback.notificationOccurred(.success)
                            } else {
                                buttonOffset = CGSize(width: geometry.size.width - buttonWidth - 35, height: 0)
                                feedback.notificationOccurred(.error)
                            }
                        }
                    })
                )
            }
//            .padding(10)
            .frame(width: geometry.size.width)
        }
    }
}

struct StopAlarmView_Previews: PreviewProvider {
    static var previews: some View {
        StopAlarmView(text: "Wake Up", buttonColor: .orange)
            .previewLayout(PreviewLayout.sizeThatFits)
        
    }
}

