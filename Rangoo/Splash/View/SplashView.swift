//
//  SplashView.swift
//  Rangoo
//
//  Created by coltec on 20/06/23.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        
        Group{
            switch viewModel.uiState{
            case .loading:
                loadingView()
                
            case .goToSignInScreen:
                viewModel.signInView()
                
            case .goToHomeScreen:
                viewModel.homeView()
            case .error(let msg):
                Text("erro \(msg)")
                
                
            }//fim switch
        }//fim group
        .onAppear(perform: {
            viewModel.onAppear()
        })
    }//fim some view
    
}//fim view

extension SplashView{
    func loadingView(error: String? = nil) -> some View {
        ZStack {
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .background(Color.white)
                .ignoresSafeArea()
                .accessibilityLabel("Logo do aplicativo")

            
        } //fim ZStack
    } //fim loadingView
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(viewModel: SplashViewModel())
    }
}
