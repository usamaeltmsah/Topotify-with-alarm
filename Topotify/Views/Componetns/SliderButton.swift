//
//  StopAlarmView.swift
//  Topotify
//
//  Created by Usama Fouad on 19/12/2022.
//

import SwiftUI

struct SliderButton: View {
    
    @State var text: String
    @State var buttonColor: Color
    @Binding var isSlidding: Bool
    var color: Color = .white
    @Binding var isDismissedFromChooseMusicView: Bool
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
                
                Text(text)
                    .font(.system(size: 30, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(buttonColor)
                    .opacity(abs(buttonOffset.width) > 0 ? 0 : 1 )
                
                HStack {
                    Capsule()
                        .fill(buttonColor)
                        .frame(width: buttonWidth + buttonOffset.width, height: buttonWidth)
                        .padding(15)
                    
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
                        if (gesture.translation.width <= (geometry.size.width - buttonWidth / 2 - 80) && gesture.translation.width >= 0) {
                            buttonOffset = gesture.translation
                        }
                    })
                    .onEnded({ _ in
                        withAnimation(.easeOut(duration: 0.5)) {
                            if (buttonOffset.width <= geometry.size.width - buttonWidth / 2 - 100) {
                                buttonOffset = .zero
                                feedback.notificationOccurred(.success)
                            } else {
//                                buttonOffset = CGSize(width: geometry.size.width - buttonWidth - 80, height: 0)
                                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                                feedback.notificationOccurred(.error)
                                isDismissedFromChooseMusicView = false
                                isSlidding = true
                            }
                        }
                    })
                )
            }
            .frame(width: geometry.size.width)
        }
    }
}

struct StopAlarmView_Previews: PreviewProvider {
    static var previews: some View {
        SliderButton(text: "Wake Up", buttonColor: .orange, isSlidding: .constant(false), isDismissedFromChooseMusicView: .constant(false))
            .previewLayout(PreviewLayout.sizeThatFits)
        
    }
}

