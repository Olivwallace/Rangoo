//
//  DetailsView.swift
//  Rangoo
//
//  Created by coltec on 28/06/23.
//

import SwiftUI


struct DetailsView: View {
        @Environment(\.dismiss) var dismiss
    
        @ObservedObject var viewModel: DetailsViewModel
        
        
        var body: some View {
            VStack{
                //Exibe Imagem Logo
                actionBar
                
                VStack(alignment: .center, spacing: 10) {
                    food_name_image
                    food_description
                    Spacer()
                }
                .frame(maxWidth: 350, maxHeight: 500)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("soft26"), lineWidth: 3)
                )
                .background(Color("soft26"))
                
                addItem
                
                // Fim VStack Interna
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity )
        }
}

extension DetailsView{
    var food_name_image: some View {
        VStack(alignment: .center, spacing: 10) {

            Text(viewModel.name)
                .font(.system(size: 25))
                .bold()

            AsyncImage(url: URL(string: viewModel.image), content:{ imagem in
                imagem
                    .resizable()
                    .frame(width: 200, height: 200)
                    .cornerRadius(5)
            }, placeholder: {
                VStack (alignment: .center){
                    ProgressView()
                        .frame(width: 150, height: 150)
                }
            })

        }
        .padding(10)
    }
}

extension DetailsView{
    var food_description: some View {
        Text(viewModel.details)
            .font(.system(size: 15))
            .multilineTextAlignment(.center)
            .padding(10)
    }
}

extension DetailsView{
    var addItem: some View {
        ButtonStyle(action: {
            
        }, text: "Adicionar Item", color: Color("baron")).padding(20)
    }
}

extension DetailsView {
    var actionBar: some View {
        ZStack(alignment: .center) {
            Image("lucas")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 100, maxHeight: 100)
                .background(Color.white)
                    
                VStack(alignment: .leading, spacing: 8) {
                    Button {
                        dismiss()
                    }label:{
                        Text("Sair")
                            .font(.system(size: 20))
                    }
                }
                .padding()
                .background(Color.white.opacity(0.8))
                .offset(x: -145, y: -40) // Ajuste o deslocamento conforme necessário
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = DetailsViewModel(food: nil)
        DetailsView(viewModel: viewModel)
    }
}
