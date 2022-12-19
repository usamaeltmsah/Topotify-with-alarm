//
//  ListBackgroundModifier.swift
//  Topotify
//
//  Created by Usama Fouad on 18/12/2022.
//

import SwiftUI

struct ListBackgroundModifier: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollContentBackground(.hidden)
        } else {
            content
        }
    }
}
