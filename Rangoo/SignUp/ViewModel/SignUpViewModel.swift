//
//  SignUpViewModel.swift
//  Rangoo
//
//  Created by coltec on 19/06/23.
//

import Foundation
import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    
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
        
}
