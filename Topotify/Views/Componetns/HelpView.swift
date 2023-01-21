//
//  HelpView.swift
//  Topotify
//
//  Created by Usama Fouad on 18/12/2022.
//

import SwiftUI


struct HelpView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Get into it!")
                        .font(.headline)
                        .foregroundColor(.white)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Tap the button below to start adding your")
                        Text("favorite music \(Image(systemName: "arrow.down"))")
                    }
                    .foregroundColor(Color(.lightBlueColor))
                    .font(.subheadline)
                }
                .padding()
                .frame(height: 100)
                
                HStack {
                    Circle()
                        .frame(width: 30)
                        .opacity(0.05)
                    
                    VStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: geometry.size.width/2, height: 10)
                            .opacity(0.2)
                        Rectangle()
                            .frame(width: geometry.size.width/3, height: 8)
                            .opacity(0.1)
                    }
                }
                .padding()
                .frame(width: geometry.size.width, height: 80, alignment: .leading)
                .background(Color.white.opacity(0.05))
                .foregroundColor(.white)
            }
        }
        .background(Color(.darkBlueColor))
        .frame(height: 200)
    }
}


struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
            .previewLayout(.sizeThatFits)
    }
}
