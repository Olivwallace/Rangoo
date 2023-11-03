//
//  PerfilViewModel.swift
//  Rangoo
//
//  Created by coltec on 21/06/23.
//

import Foundation
import SwiftUI
import FirebaseDatabase
import Firebase

class DetailsViewModel: ObservableObject {
    
    //----------- Campos de Autenticacao
    @Published var image: String = "https://firebasestorage.googleapis.com/v0/b/rangooapp-16032.appspot.com/o/imagens%2Ffranguinho.png?alt=media&token=811d5335-f23c-48a2-bf9d-b610d0983adb"
    @Published var name: String = "Franguinho"
    @Published var details: String = "O frango ao molho foi feito com pedaços de frango, temperados com sal, pimenta e outros temperos a gosto, cozidos em um molho que contém ingredientes como tomate, cebola, alho, ervas, especiarias."
     
    @Published var uiState: DetailsUIState = .loading
    
    init(food: Food?){
        if let food = food{
            self.image = food.getImage()
            self.name = food.getName()
            self.details = food.getDetails()
        }
    }
    
}
