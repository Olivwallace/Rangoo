//
//  ListaViewModel.swift
//  Rangoo
//
//  Created by coltec on 05/07/23.
//
import Foundation
import SwiftUI
import Firebase


class ListaViewModel: ObservableObject {
    
    @Published var maxList: Bool
    @Published var uiState: ListaUIState = .loading
    @Published var cards: [CardViewStyle] = []
    
    var userList: [Food] = []
    
    init(){
        maxList = false
    }
  
    func getWeekMenu(){
        
        var c: Int = 0
        let cores: [Color] = [Color("pumpkin"),Color("baron"),Color("vegan")]
        
        FirebaseNetwork.getWeekMenu(completion: { snapshot in
            if let data = snapshot {
                
                for i in data.children {
                    if let dataSnap = i as? DataSnapshot, let item = dataSnap.value as? [String: String] {
                        

                        let id = dataSnap.key
                        let image = item["imagem"] ?? ""
                        let name = item["name"] ?? ""
                        let resume = item["resumo"] ?? ""
                        let details = item["description"] ?? ""
                        
                        self.cards.append(
                            CardViewStyle(food:
                                            Food(id: id , image: image, name: name, resume: resume, details: details),
                                          color: cores[c % 3], actionAdd: self.addItemList)
                        )
                    }
                    c += 1
                }
            }
        })
    }
    
    func addItemList(item: Food) -> Void {
        if self.userList.count < 5 {
            print(self.userList.count)
            self.userList.append(item)
        }
        
        if self.userList.count == 5 {
            maxList = true
        }
    }
    
}

