//
//  ListaView.swift
//  Rangoo
//
//  Created by coltec on 26/06/23.
//

import SwiftUI

struct ListaView: View {
    
    @ObservedObject var viewModel: ListaViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 10){
            
            ScrollView{
                if viewModel.cards != [] {
                    var qtd = viewModel.cards.count
                    
                    ForEach (0..<qtd) { i in
                        viewModel.cards[i]
                    }
                        
                } else {
                    //
                }
                
                
            }
            .onAppear{
                viewModel.getWeekMenu()
            }
            .background(Color("soft26"))
            .padding(10)
            
        }
    }
}

struct ListaView_Previews: PreviewProvider {
    static var previews: some View {
        ListaView(viewModel: ListaViewModel())
    }
}
