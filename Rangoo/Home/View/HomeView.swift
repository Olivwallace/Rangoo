//
//  HomeView.swift
//  Rangoo
//
//  Created by coltec on 20/06/23.
//

import SwiftUI

struct HomeView: View {

    @State var logado: Bool = true
    @ObservedObject var viewModel: HomeViewModel
    @State var selection = 0
    
    var body: some View {
        if logado{
            TabView(selection: $selection) {
                    
                    viewModel.rangooView(selection: $selection)
                        .tabItem{
                            Image("botao-home")
                            Text("Home")
                                .foregroundColor(.black)
                        }.tag(0)

                    viewModel.listaView()
                        .tabItem{
                            Image("lista-icon")
                            Text("Lista")
                                .foregroundColor(.black)
                        }.tag(1)

                    viewModel.perfilView(logado: $logado)
                        .tabItem{
                            Image("usuario-de-perfil")
                            Text("Perfil")

                        }.tag(2)
                    
                }
                .background(Color.white)
                .accentColor(Color.black)
        } else {
            viewModel.goToSignInView()
        }
    
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
