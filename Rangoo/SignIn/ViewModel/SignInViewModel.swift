//
//  SignInViewModel.swift
//  Rangoo
//
//  Created by coltec on 13/06/23.
//

import Foundation
import Firebase
import Combine
import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import AuthenticationServices

class SignInViewModel: ObservableObject {
    
    @Published var _CLIENT_CODE: String = ""
    
    private var cancellable: AnyCancellable?
    private var cancellableRequest: AnyCancellable?
    private let publisher = PassthroughSubject<Bool, Never>()
    
    let database = Database.database().reference()
    
    //----------- Campos de Autenticacao
    @Published var name: String = ""
    @Published var phone: String = ""
    @Published var address: String = ""
    @Published var birthday: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var uiState: SignInUIState = .none
    
    init(){
     
        cancellable = publisher.sink{ value in
            if(value){
                self.uiState = .goToHomeScreen
            }
        }
        
    }
    
    //--------------- Finaliza esculta
    deinit{
        cancellable?.cancel()
    }
    
    
    func loginGoogleUser(){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: Application_utility.rootViewController){ user, erro in
            
            if let error = erro {
                print(error.localizedDescription)
                return
            }
            
            guard let user = user?.user, let idToken = user.idToken else { return }
            
            let accessToken = user.accessToken
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { res, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if let currentUser = Auth.auth().currentUser {
                    if let name = currentUser.displayName{
                        self.database.child("users").child(currentUser.uid).child("name").setValue(name)
                    }
                    
                    if let email = currentUser.email{
                        self.database.child("users").child(currentUser.uid).child("email").setValue(email)
                    }
                    
                    if let phone = currentUser.phoneNumber{
                        self.database.child("users").child(currentUser.uid).child("phone").setValue(phone)
                    }
                    
                }
                
                guard let user = res?.user else { return }
                self.uiState = .goToHomeScreen
                
            }
            
        }
    }
    
    func loginEmailUser(){
        Auth.auth().signIn(withEmail: email, password: password){ (user, error) in
            
            if error != nil {
                print("Dados Incorretos")
            } else {
                self.uiState = .goToHomeScreen
            }
             
        }
    }
    
    func recuperaSenha(completion: @escaping (Bool) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: self.email ) { error in
            if let error = error {
                print("Erro ao enviar email de recuperacao")
                completion(false)
            } else {
                print("Sucesso ao enviar o email de recuperacao")
                completion(true)
            }
        }
    }
    
}

extension SignInViewModel {
    func validateForms() -> Bool {
        return !email.isEmail() || !password.isPassword()
    }
}

extension SignInViewModel {
    func signUpView() -> some View{
        return SignInViewRouter.makeSignUpView(publisher: publisher)
    }
    
    func homeView() -> some View{
        return SignInViewRouter.makeHomeView()
    }
}

