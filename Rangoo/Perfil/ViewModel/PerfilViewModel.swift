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

class PerfilViewModel: NSObject, ObservableObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //----------- Campos de Autenticacao
    @Published var image: UIImage? = UIImage(named: "adicionar-foto")
    @Published var name: String = ""
    @Published var phone: String = ""
    @Published var address: String = ""
    @Published var birthday: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    
    @Published var uiState: PerfilUIState = .loading
    
    func deslogaUsuario() {
        
        do {
            try Auth.auth().signOut()
        } catch _ as NSError {
            print("Erro ao desconectar usuario")
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
    
    func getUserData() {
        FirebaseNetwork.getUserData(completion: { User in
            
            if let name = User["name"]{
                self.name = name
            }
            
            if let phone = User["phone"]{
                self.phone = phone
            }
            
            if let address = User["address"]{
                self.address = address
            }
            
            if let birthday = User["birthday"]{
                self.birthday = birthday
            }
            
            if let email = User["email"]{
                self.email = email
            }
                
        })
        
        FirebaseNetwork.getImageUser(userId: Auth.auth().currentUser!.uid) { Image in
            if Image != nil {
                self.image = Image
            }
        }
        
        
    }
    
    func uptadeImage(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        
        UIApplication.shared.windows.first?.rootViewController?.present(imagePickerController, animated: true)
            
    }
    
//    func retrieveDataFromFirebase() {
//        database.child("username").observeSingleEvent(of: .value) { snapshot in
//            if let value = snapshot.value as? String {
//                let nome = value
//            }
//        }
//    }
    
    
}

extension PerfilViewModel{
    func signInView() -> some View{
        return PerfilViewRouter.makeSignInView()
    }
}

extension PerfilViewModel {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                
                self.image = image
                FirebaseNetwork.updateImageUser(image: image, userId: Auth.auth().currentUser!.uid)
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
}
