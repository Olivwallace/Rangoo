//
//  Application_utility.swift
//  Rangoo
//
//  Created by coltec on 15/06/23.
//

import Foundation
import SwiftUI
import UIKit

// TODO: Descobrir o que faz kkkkk
final class Application_utility {
    static var rootViewController: UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
