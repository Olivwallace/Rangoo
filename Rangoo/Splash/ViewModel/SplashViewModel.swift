//
//  SplashViewModel.swift
//  Rangoo
//
//  Created by coltec on 20/06/23.
//

import Foundation
import SwiftUI
import Firebase

class SplashViewModel: ObservableObject{
    
    let user = Auth.auth().currentUser
    @Published var uiState: SplashUIState = .loading
    
    func onAppear(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if(self.user != nil) {
                self.uiState = .goToHomeScreen
            } else {
                self.uiState = .goToSignInScreen
            }
        }
    }
    
    
}

extension SplashViewModel{
    func signInView() -> some View{
        return SplashViewRouter.makeSignInView()
    }
}

extension SplashViewModel{
    func homeView() -> some View{
        return SplashViewRouter.makeHomeView()
    }
}
