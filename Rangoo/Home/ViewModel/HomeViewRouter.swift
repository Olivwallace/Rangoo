//
//  HomeViewRouter.swift
//  Rangoo
//
//  Created by coltec on 21/06/23.
//

import Foundation
import SwiftUI

enum HomeViewRouter{
    
    static func makeRangooView(viewModel: RangooViewModel, selectedTab: Binding<Int>) -> some View {
        
        return RangooView(viewModel: viewModel, selectedTab: selectedTab)
    }
    
    static func makePerfilView(viewModel: PerfilViewModel, logado: Binding<Bool>) -> some View {
        return PerfilView(viewModel: viewModel, logado: logado)
    }
    
    static func makeListaView(viewModel: ListaViewModel) -> some View {
        return ListaView(viewModel: viewModel)
    }
    
    static func makeSignInView(viewModel: SignInViewModel) -> some View {
        return SignInView(viewModel: viewModel)
    }
}
