//
//  AppDelegate.swift
//  Rangoo
//
//  Created by coltec on 15/06/23.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        FirebaseApp.configure()
        return GIDSignIn.sharedInstance.handle(url)
    }

}
