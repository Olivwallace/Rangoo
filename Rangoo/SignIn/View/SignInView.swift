//
//  SignInView.swift
//  Rangoo
//
//  Created by coltec on 13/06/23.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift
import Firebase
import SwiftUI
import UIKit

struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel

    @Environment(\.dismiss) var dismiss
    @State var action: Int? = 0
    @State var redefinirSenha: Bool = false
    
    @State var navigationBarHidden = true
    
    var body: some View {
        ZStack{
            if case SignInUIState.goToHomeScreen = viewModel.uiState{
                viewModel.homeView()
            }else{
                NavigationView{
                    ScrollView{
                        VStack(alignment: .center){
                            
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .padding(.top, 80)
                                .padding(.horizontal, 10)
                            

                            VStack(alignment: .center, spacing: 25){
                            
                                VStack{
                                    emailView
                                    passwordView
                                    forgotPasswordButton
                                }
                                
                                buttonLogin
                                buttonLoginGoogle
                                Text("ou")
                                signUpButton
                                
                                
                            }// End VStack Components
                        } // End VStack Externa
                    } // End ScrollView
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 10)
                // End NavigationView - SignUp
            } // End Else
        } // End ZStack GoToHomeScreen
        .sheet(isPresented: $redefinirSenha) {
            redefinirSenhaView
        }
    }
}

// ------ Define Campo de Email
extension SignInView {
    var emailView: some View {
        EditTextView(placeholder: "Email",
                     text: $viewModel.email,
                     error: "Email Inválido",
                     failure: !viewModel.email.isEmail(), color: Color("dark"))
        .accessibilityLabel("Digite seu email")
        
    }
}

// ------ Define Campo de Senha
extension SignInView{
    var passwordView: some View{
        EditTextView(placeholder: "Password",
                     text: $viewModel.password,
                     error: "Senha Inválida",
                     failure: viewModel.password.count < 8,
                     keyboard: .emailAddress, color: Color("dark"), isSecure: true)
        .accessibilityLabel("Digite sua senha")
    }
}

// ------ Define Button de Login
extension SignInView {
    var buttonLogin: some View {
        ButtonStyle(action: {
            viewModel.loginEmailUser()
        }, text: "Entrar",
                    disabled: viewModel.validateForms(),
                    showProgress: self.viewModel.uiState == SignInUIState.loading, color: Color("baron"))
        .accessibilityLabel("Clique para logar")
    }
}

// ------ Define Button de Login com Google
extension SignInView {
    var buttonLoginGoogle: some View {
        ButtonStyle(action: {
            viewModel.loginGoogleUser()
        }, text: "Entrar com Google", showProgress: self.viewModel.uiState == SignInUIState.loading, icon: "google_icon")
        .accessibilityLabel("Clique para logar com o Google")
    }
}

// ---- Campo Esqueci Senha
extension SignInView {
    var forgotPasswordButton : some View {
        HStack{
            Spacer()
            Button(action: {
                redefinirSenha = true
            }, label: {
                Text("Redefinir Senha")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 14))
            })
            .accessibilityLabel("Clique para redefinir a senha")
        }
    }
}

// ---- Campo Esqueci Senha
extension SignInView {
    var signUpButton : some View {
        VStack {
            ZStack {
                NavigationLink(
                    destination: viewModel.signUpView(),
                    tag: 1,
                    selection: $action,
                    label: {EmptyView()}
                )
                Button("Cadastre-se"){
                    self.action = 1
                }
                .foregroundColor(Color.gray)
                .font(.system(size: 15))
                .accessibilityLabel("Clique para cadastrar um novo usuario")
                
            }
        }
    }
}

extension SignInView {
    var redefinirSenhaView: some View {
        VStack(alignment: .center, spacing: 15) {
            
            VStack(alignment: .leading, spacing: 8) {
                Button {
                    
                }label:{
                    Text("Sair")
                        .font(.system(size: 20))
                }
            }
            .padding()
            .background(Color.white.opacity(0.8))
            .offset(x: -145, y: -10)
            
            //Exibe Imagem Logo
            Image("lucas")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 120, maxHeight: 120)
                .padding(.horizontal, 10)
                .background(Color.white)
                .accessibilityLabel("Imagem da logo")
            
            VStack(alignment: .center, spacing: 10){
                
                Text("Redefinir senha")
                    .foregroundColor(.black)
                    .font(.system(size: 30))
                    .font(.title.bold())
                    .padding(.vertical, 15)
                    .accessibilityLabel("Clique para logar")
                
                EditTextView(placeholder: "E-mail",
                             text: $viewModel.email,
                             error: "Email Inválido",
                             failure: !viewModel.email.isEmail(), color: Color("dark"))
                .padding(20)
                .accessibilityLabel("Digite o seu email")
                
                recuperarSenha
                
                
                
            }   // End VStack Interna
        } // Fim VStack Externa
        .padding()
        .background(Color.white.opacity(0.8))
        .offset(x: 0, y: -110)
    }
}

extension SignInView {
    var recuperarSenha: some View{
        ButtonStyle(action: {
            viewModel.recuperaSenha { sucess in
                if sucess {
                    //alert(message: "Uma mensagem de redefinicão foi enviada para o seu e-mail.")
                } else {
                    //alert(message: "Erro ao enviar a mensagem de redefinicao.")
                }
            }
            
        }, text: "Enviar",
           color: Color("baron"))
        .padding(20)
        .accessibilityLabel("Botao enviar")
    }
}

extension SignInView{
    func alerta(message: String) {
        
        let alert = UIAlertController(title: "Redefinir senha", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            
        }
        alert.addAction(okAction)
        
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            viewController.present(alert, animated: true, completion: nil)
        }
        
    } //fim alert
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewModel: SignInViewModel())
    }
}
