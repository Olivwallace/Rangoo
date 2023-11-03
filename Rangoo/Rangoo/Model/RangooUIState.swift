//
//  RangooUIState.swift
//  Rangoo
//
//  Created by coltec on 21/06/23.
//

import Foundation

enum RangooUIState: Equatable{
    case loading
    case emptyList
    case fullList
    case error(String)
}
