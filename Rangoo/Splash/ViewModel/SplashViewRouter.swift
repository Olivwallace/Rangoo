//
//  SplashViewRouter.swift
//  Rangoo
//
//  Created by coltec on 20/06/23.
//

import SwiftUI

enum SplashViewRouter{
    
    static func makeSignInView() -> some View{
        let viewModel = SignInViewModel()
        return SignInView(viewModel: viewModel)
    }
    
    static func makeHomeView() -> some View{
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
    
}
