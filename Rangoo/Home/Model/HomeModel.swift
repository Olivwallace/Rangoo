//
//  HomeModel.swift
//  Rangoo
//
//  Created by coltec on 20/06/23.
//

import Foundation

enum HomeUIState: Equatable {
    case none
    case loading
    case empty
    case completed
    case error(String)
}
