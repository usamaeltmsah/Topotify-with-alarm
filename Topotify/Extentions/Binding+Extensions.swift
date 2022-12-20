//
//  Binding+Extensions.swift
//  Topotify
//
//  Created by Usama Fouad on 20/12/2022.
//

import SwiftUI

extension Binding<String>: Equatable {
    public static func == (lhs: Binding<Value>, rhs: Binding<Value>) -> Bool {
        return lhs.wrappedValue == rhs.wrappedValue
    }
}
