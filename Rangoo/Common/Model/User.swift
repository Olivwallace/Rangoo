//
//  User.swift
//  Rangoo
//
//  Created by coltec on 20/06/23.
//

import Foundation

class User{
    
    private var name: String
    private var phone: String
    private var address: String
    private var birthday: String
    
    private var loginData: LoginData
    
    init(name: String, phone: String, address: String, birthday: String, email: String, password: String) {
        self.name = name
        self.phone = phone
        self.address = address
        self.birthday = birthday
        self.loginData = LoginData(email: email, password: password)
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getPhone() -> String {
        return self.phone
    }
    
    func getAddress() -> String {
        return self.address
    }
    
    func getBirthday() -> String {
        return self.birthday
    }
    
    func getLoginData() -> LoginData {
        return self.loginData
    }
    
    func createObject() -> [String: String] {
        let user = [
            "name": name,
            "phone": phone,
            "address": address,
            "birthday": birthday,
            "email": loginData.getEmail()
        ]
        
        return user
    }

}
