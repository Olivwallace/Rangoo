//
//  SignUpModel.swift
//  Rangoo
//
//  Created by coltec on 19/06/23.
//

import Foundation

enum SignUpUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
