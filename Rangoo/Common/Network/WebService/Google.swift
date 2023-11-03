//
//  Google.swift
//  Rangoo
//
//  Created by coltec on 27/06/23.
//

import Foundation
import Firebase
import GoogleSignIn
import GoogleSignInSwift
import AuthenticationServices

class GoogleNetwork{
    
   
    public static func signIn(completion: @escaping (Bool, String) -> Void){
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
                    completion(false, error.localizedDescription)
                    return
                }
                
                guard let user = res?.user else { return }
                completion(true, user.uid)
                
            }
        }
    }
    
}
