//
//  CustomTextFieldStyle.swift
//  Rangoo
//
//  Created by coltec on 13/06/23.
//

import Foundation
import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    
    public var color: Color
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.vertical, 15)
            .padding(.horizontal, 15)
            .overlay(RoundedRectangle(cornerRadius: 6.0)
                .stroke(color, lineWidth: 0.7))
    }
}
