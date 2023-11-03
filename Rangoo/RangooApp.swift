//
//  RangooApp.swift
//  Rangoo
//
//  Created by coltec on 13/06/23.
//

import SwiftUI

//Imports necessarios para o firebase
import UIKit
import FirebaseCore
import GoogleSignIn

@main
struct RangooApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: SplashViewModel())
        }
    }
}

