//
//  RangooViewModel.swift
//  Rangoo
//
//  Created by coltec on 21/06/23.
//

import Foundation
import SwiftUI
import Firebase

class RangooViewModel: ObservableObject {
    @Published var uiState: RangooUIState = .emptyList
    
    @Published var cards: [CardViewStyle] = []
    var c: Int = 0
    
    private var cores: [Color] = [Color("pumpkin"),Color("baron"),Color("vegan")]

    func getWeekMenu(){
        FirebaseNetwork.getWeekMenu(completion: { snapshot in
            if let data = snapshot {
                
                for i in data.children {
                    if let dataSnap = i as? DataSnapshot, let item = dataSnap.value as? [String: String] {
                        
                        let id = dataSnap.key
                        let image = item["imagem"] ?? ""
                        let name = item["name"] ?? ""
                        let resume = item["resumo"] ?? ""
                        let details = item["description"] ?? ""
                        
                        print(image, name, resume, details)
                        self.cards.append(
                            CardViewStyle(food:
                                            Food(id: id, image: image, name: name, resume: resume, details: details),
                                          color: self.cores[self.c % 3])
                        )
                        
                        self.c += 1
                    }
                }
            }
        })
    }
}

