//
//  SignUpViewModel.swift
//  Rangoo
//
//  Created by coltec on 19/06/23.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {

    let viewModelLista = ListaViewModel()
    let viewModelRangoo = RangooViewModel()
    let viewModelPerfil = PerfilViewModel()
    let viewModelSignIn = SignInViewModel()
    
    @Published var uiState: HomeUIState = .none
 
}

extension HomeViewModel{
    func rangooView(selection: Binding<Int>) -> some View{
        return HomeViewRouter.makeRangooView(viewModel: viewModelRangoo, selectedTab: selection)
    }
}

extension HomeViewModel{
    func perfilView(logado: Binding<Bool>) -> some View{
        return HomeViewRouter.makePerfilView(viewModel: viewModelPerfil, logado: logado)
    }
}

extension HomeViewModel{
    func listaView() -> some View{
        return HomeViewRouter.makeListaView(viewModel: viewModelLista)
        
    }
}

extension HomeViewModel{
    func goToSignInView() -> some View{
        return HomeViewRouter.makeSignInView(viewModel: viewModelSignIn)
    }
}
