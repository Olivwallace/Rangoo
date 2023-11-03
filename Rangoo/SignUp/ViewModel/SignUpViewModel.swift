//
//  SignUpViewModel.swift
//  Rangoo
//
//  Created by coltec on 19/06/23.
//

import Foundation
import Firebase
import Combine
import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import AuthenticationServices
import Firebase
import FirebaseDatabase

class SignUpViewModel: ObservableObject {
    
    let database = Database.database().reference() //TODO: Mover daqui
    
    private var cancellable: AnyCancellable?
    private var cancellableRequest: AnyCancellable?
    private let publisher = PassthroughSubject<Bool, Never>()
    
    
    @Published var uiState: SignUpUIState = .none
    
    //----------- Campos de Autenticacao
    @Published var name: String = ""
    @Published var phone: String = ""
    @Published var address: String = ""
    @Published var birthday: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    init(){
        
        cancellable = publisher.sink{ value in
            if(value){
                self.uiState = .success
            }
        }
        
    }
    
    //--------------- Finaliza esculta
    deinit{
        cancellable?.cancel()
    }
    
    func createUser() {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (result, error) in
            
            if error != nil {
                print("Erro ao cadastrar")
            }
            
            guard let user = result?.user else {
                    print("Usuário não encontrado")
                    return
            }
        
            
            self.database.child("users").child(user.uid).setValue(["name": self.name,
                                                                   "phone": self.phone,
                                                                   "address": self.address,
                                                                   "birthday": self.birthday,
                                                                   "email": self.email])
            
        })
    }
        
}

extension SignUpViewModel {
    func validateForms() -> Bool {
        return name.isEmpty || !phone.isPhoneNumber() || address.isEmpty || !birthday.isDate() || !email.isEmail() || !password.isPassword()
    }
}
