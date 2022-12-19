//
//  CircleGroupView.swift
//  Topotify
//
//  Created by Usama Fouad on 19/12/2022.
//

import SwiftUI

struct CircleGroupView: View {
    var circleGroupColor: Color = .gray
    @State var isAnimation: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(circleGroupColor.opacity(0.2), lineWidth: 40)
                .frame(width: 260, alignment: .center)
            
            Circle()
                .stroke(circleGroupColor.opacity(0.2), lineWidth: 80)
                .frame(width: 260, alignment: .center)
        }
        .scaleEffect(isAnimation ? 1 : 0.5)
        .animation(.easeOut(duration: 1), value: isAnimation)
        .onAppear {
            isAnimation.toggle()
        }
    }
}

struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CircleGroupView()
    }
}

