//
//  GradientButton.swift
//  Topotify
//
//  Created by Usama Fouad on 20/12/2022.
//

import SwiftUI

struct GradientButton: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.title2)
            .frame(width: 180, height: 50, alignment: .center)
            .background(LinearGradient(colors: [Color(.lightOrangeColor), Color(.darkOrangeColor)], startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(25)
    }
}

struct GradientButton_Previews: PreviewProvider {
    static var previews: some View {
        GradientButton(text: "Button")
    }
}
