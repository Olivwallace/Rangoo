//
//  PerfilViewRouter.swift
//  Rangoo
//
//  Created by coltec on 21/06/23.
//

import Foundation
import SwiftUI


enum PerfilViewRouter{
    
    static func makeSignInView() -> some View{
        let viewModel = SignInViewModel()
        return SignInView(viewModel: viewModel)
    }
    
}
