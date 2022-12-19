//
//  Int+Extenstions.swift
//  Topotify
//
//  Created by Usama Fouad on 19/12/2022.
//

import Foundation

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
