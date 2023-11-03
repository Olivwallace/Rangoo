//
//  LoginData.swift
//  Rangoo
//
//  Created by coltec on 27/06/23.
//

import Foundation

class LoginData {
    private let email: String
    private let password: String
    
    init(email: String, password: String){
        self.email = email
        self.password = password
    }
    
    func getEmail() -> String { return self.email }
    func getPassword() -> String { return self.password }
}

