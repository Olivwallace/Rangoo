//
//  ListUser.swift
//  Rangoo
//
//  Created by coltec on 29/06/23.
//

import Foundation

class ListUser {
    
    private var userID: String
    private var foodsID: [String]
    
    init(userID: String, foodsID: [String]){
        self.userID = userID
        self.foodsID = foodsID
    }
    
    private func getUserID() -> String { return self.userID }
    private func getList() -> [String] { return self.foodsID }
    
}
