//
//  RangooView.swift
//  Rangoo
//
//  Created by coltec on 21/06/23.
//

import SwiftUI

struct RangooView: View {
    
    @ObservedObject var viewModel: RangooViewModel
    @Binding var selectedTab: Int
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 10){
            
            if viewModel.uiState == .emptyList {
                listaEmptyList()
                
            } else if viewModel.uiState == .fullList{
                ScrollView{
                    if viewModel.cards != [] {
                        let qtd = viewModel.cards.count

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

        }// fim VStack
    }
}

struct RangooView_Previews: PreviewProvider {
    static var previews: some View {
        RangooView(viewModel: RangooViewModel(), selectedTab: .constant(0))
    }
}

extension RangooView{
    func lucasView(error: String? = nil) -> some View {
        ZStack {
            
            Image("camaleao")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .background(Color.white)
                .ignoresSafeArea()

            
        } //fim ZStack
    } //fim lucasView
}

extension RangooView{
    func listaEmptyList(error: String? = nil) -> some View {
        VStack{
            Text("Aparentemente você está sem")
                .font(.system(size: 25))
            Text("fome essa semana!")
                .font(.system(size: 25))
                
            lucasView()
            buttonOpcoes
                .padding(40)
        }
        .padding(30)
    }
}

extension RangooView{
    var buttonOpcoes: some View {
        ButtonStyle(action: {
            selectedTab = 1
        }, text: "Deixe-me ver as opcões",
                    disabled: false,
                    showProgress: false, color: Color("baron"))
    }
}


