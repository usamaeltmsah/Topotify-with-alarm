//
//  ColorNames.swift
//  Topotify
//
//  Created by Usama Fouad on 17/12/2022.
//

import SwiftUI

enum ColorName: String {
    case darkBlueColor = "DarkBlueColor"
    case lightBlueColor = "LightBlueColor"
    case darkOrangeColor = "DarkOrangeColor"
    case lightOrangeColor = "LightOrangeColor"
}

extension Color {
    
    /// Creates an image using `ColorName`, an enum which contains the names of
    /// all the image assets.
    init(_ name: ColorName) {
        self.init(name.rawValue)
    }
}

extension UIColor {
    /// Creates an image using `ColorName`, an enum which contains the names of
    /// all the image assets.
    convenience init?(_ name: ColorName) {
        self.init(named: name.rawValue)
    }
}
