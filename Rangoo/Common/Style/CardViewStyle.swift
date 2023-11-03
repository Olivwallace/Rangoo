//
//  CardViewStyle.swift
//  Rangoo
//
//  Created by coltec on 21/06/23.
//

import SwiftUI

struct CardViewStyle: View, Equatable {
    
        
        static func == (lhs: CardViewStyle, rhs: CardViewStyle) -> Bool {
            return lhs.food == rhs.food && lhs.color == rhs.color
        }
    
        var food:Food
        var color: Color = Color("vegan")
    
        var actionAdd: (Food) -> Void = { i in }
        
        @State var action: Bool = false
         
        var body: some View {
                HStack{
                    
                    AsyncImage(url: URL(string: food.getImage()), content:{ imagem in
                        imagem
                            .resizable()
                            .frame(width: 150, height: 100)
                            .cornerRadius(5)
                    }, placeholder: {
                        VStack (alignment: .center){
                            ProgressView()
                                .frame(width: 150, height: 150)
                        }
                    })
                    
                    
                    VStack (alignment: .listRowSeparatorLeading , spacing: 5){
                        
                        Text(food.getName())
                            .font(.title3)
                            .fontWeight(.thin)
                            .accessibilityLabel("Prato \(food.getName())")
                        
                        Text(food.getResume())
                            .font(.system(size: 10))
                            .accessibilityLabel("Prato \(food.getResume())")
                        
                    }
                    .frame(minWidth: 150, minHeight: 90)
                    .frame(maxWidth: 150, maxHeight: 90)
                    .padding(5)
                    
                    VStack (spacing: 50){
                        
                        
                        Button{
                            self.action = true
                        } label: {
                            Image(systemName: "info.circle.fill")
                                .resizable()
                                .frame(maxWidth: 15, maxHeight: 15)
                                .foregroundColor(Color.white)
                                .accessibilityLabel("Botão de informações do prato")
                        }
                        
                        Button{
                            actionAdd(self.food)
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(maxWidth: 20, maxHeight: 20)
                                .foregroundColor(Color.white)
                                .accessibilityLabel("Botão de adicionar prato")
                        }
                        
                    }.padding(5)
                    
                }.sheet(isPresented: $action) {
                    let viewModel = DetailsViewModel(food: self.food)
                    DetailsView(viewModel: viewModel)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 3.5)
                        .stroke(color, lineWidth: 2)
                )
                .background(color)
            }

}



struct CardViewStyle_Previews: PreviewProvider {
         static var previews: some View {
             CardViewStyle(food: Food(), actionAdd: { food in })
                           .previewLayout(.sizeThatFits)
         }
}
