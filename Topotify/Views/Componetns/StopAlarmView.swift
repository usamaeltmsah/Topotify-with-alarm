//
//  StopAlarmView.swift
//  Topotify
//
//  Created by Usama Fouad on 19/12/2022.
//

import SwiftUI

struct StopAlarmView: View {
    var color: Color = .black
    var body: some View {
        ZStack {
            Capsule()
                .fill(color.opacity(0.2))
                .frame(height: 80)
            
            Capsule()
                .fill(color.opacity(0.2))
                .frame(height: 60)
                .padding()
            
            Text("Stop Alarm")
                .font(.system(size: 30, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.yellow)
            
            HStack {
//                Capsule()
//                    .fill(.yellow)
//                    .frame(width: 50, height: 50)
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
                .frame(width: 70, alignment: .leading)
                .padding(5)
                
                Spacer()
            }
        }
        .padding(.horizontal, 10)
    }
}

struct StopAlarmView_Previews: PreviewProvider {
    static var previews: some View {
        StopAlarmView()
            .previewLayout(PreviewLayout.sizeThatFits)
        
    }
}

