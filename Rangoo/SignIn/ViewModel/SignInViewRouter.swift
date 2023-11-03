//
//  SignInViewRouter.swift
//  Rangoo
//
//  Created by coltec on 19/06/23.
//

import SwiftUI
import Combine
import Foundation

enum SignInViewRouter {
    static func makeSignUpView(publisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = SignUpViewModel()
        return SignUpView(viewModel: viewModel)
    }
    static func makeHomeView() -> some View{
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
}

