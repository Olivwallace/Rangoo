//
//  Firebase.swift
//  Rangoo
//
//  Created by coltec on 20/06/23.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage

class FirebaseNetwork {

    private static func getDataBase(data: String) -> DatabaseReference {
        return Database.database().reference().child(data)
    }
    
    public static func signIn(email: String, pass: String, completion: @escaping (Bool, String) -> Void){
        Auth.auth().signIn(withEmail: email, password: pass){ (User, Error) in
            if let erro = Error {
                completion(false, erro.localizedDescription)
            } else if let user = User {
                completion(true, user.user.uid)
            }
        }
    }
    
    public static func signUp(user: User, completion: @escaping (Bool, String) -> Void){
        Auth.auth().createUser(withEmail: user.getLoginData().getEmail(), password: user.getLoginData().getPassword()){ (User, Error) in
            if let erro = Error {
                completion(false, erro.localizedDescription)
            }
            
            guard let usuario = User?.user else {
                print("Usuario não localizado")
                return
            }
            
            self.getDataBase(data: "users").child(usuario.uid).setValue(user.createObject())
            completion(true, usuario.uid)
        }
    }
    
    public static func getUserData(completion: @escaping ([String: String]) -> Void){
        self.getDataBase(data: "users").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value) {snapshot in
            if let user = snapshot.value as? [String: String] {
                completion(user)
            }
        }
    }
    
    public static func getImage(caminho: String, completion: @escaping (UIImage?) -> Void){
        let storageRef = Storage.storage().reference().child(caminho)
        
        storageRef.getData(maxSize: 1 * 2048 * 2048) { (data, error) in
            if let error = error {
                print("Error ao recuperar imagem \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let imageData = data, let image = UIImage(data: imageData) {
                completion(image)
            } else {
                print("Falha na conversao da imagem para UIImage")
                completion(nil)
            }
        }
        
    }
    
    public static func getImageUser(userId: String, completion: @escaping (UIImage?) -> Void){
        
        getImage(caminho: "imageUsers/\(userId).jpg") {
            response in completion(response)
        }
    }
    
    public static func updateImageUser(image: UIImage, userId: String){
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Falha na convercao da imagem")
            return
        }
        
        let storageRef = Storage.storage().reference().child("imageUsers/\(userId).jpg")
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        storageRef.putData(imageData, metadata: metaData) { (metaData, error) in
            if let error = error {
                print(error)
                return
            }
        }
        
        print("Sucesso no upload")
    }
    
    public static func getWeekMenu(completion: @escaping (DataSnapshot?) -> Void ){
        self.getDataBase(data: "menu").observeSingleEvent(of: .value, with: { snapshot in
            
            guard snapshot.exists() else {
                print("Nao ha dados na tabela")
                completion(nil)
                return
            }
            
            completion(snapshot)
        }){
            error in
                print("Erro ao recuperar os dados: \(error.localizedDescription)")
        }
    }
    
}
