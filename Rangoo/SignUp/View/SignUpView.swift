//
//  SignUpView.swift
//  Rangoo
//
//  Created by Rangoo Group on 13/06/23.
//

import SwiftUI
import Combine

struct SignUpView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SignUpViewModel
    
    var body: some View {
        ZStack{
                ScrollView(showsIndicators: false){
                    VStack(alignment: .center, spacing: 15){
                        
                        //Exibe Imagem Logo
                        Image("lucas")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 120, maxHeight: 120)
                            .padding(.horizontal, 10)
                            .background(Color.white)
                            .accessibilityLabel("Imagem da logo do aplicativo")
                    
                        Spacer(minLength: 5)
                        VStack(alignment: .center, spacing: 10){
                            
                            Text("Cadastre-se")
                                .foregroundColor(.black)
                                .font(.system(size: 40))
                                .font(.title.bold())
                                .padding(.vertical, 15)
                                .accessibilityLabel("Tela de cadastro")
                            
                            fullNameView
                            phoneView
                            addressView
                            birthdayView
                            emailView
                            passView
                            
                            
                            
                        }   // End VStack Interna
                        
                        Spacer(minLength: 10)
                        signUpButton
                        
                        
                        
                    }       // End VStack Externa
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 32)
                .background(Color.white)
                 // End ScroolView
         
        }                   // End ZStack
    }                       // End Some View
}



// ------ Define Campo de Nome
extension SignUpView{
    var fullNameView: some View {
        EditTextView(placeholder: "Nome",
                     text: $viewModel.name,
                     error: "Nome Inválido",
                     failure: viewModel.name.isEmpty, color: Color("dark"))
        .accessibilityLabel("Digite seu nome")
    }
}

// ------ Define Campo de Contato
extension SignUpView{
    var phoneView: some View {
        EditTextView(placeholder: "Contato",
                     text: $viewModel.phone,
                     error: "Contato Inválido",
                     failure: !viewModel.phone.isPhoneNumber(), color: Color("dark"))
        .accessibilityLabel("Digite seu contato")
    }
}

// ------ Define Campo de Endereco
extension SignUpView{
    var addressView: some View {
        EditTextView(placeholder: "Endereço",
                     text: $viewModel.address,
                     error: "Endereço Inválido",
                     failure: viewModel.address.isEmpty, color: Color("dark"))
        .accessibilityLabel("Digite seu endereco")
    }
}

// ------ Define Campo de Aniversario
extension SignUpView{
    var birthdayView: some View{
       EditTextView(placeholder: "Aniversário",
                    text: $viewModel.birthday,
                     error: "Data Inválida",
                     failure: !viewModel.birthday.isDate(), color: Color("dark"))
       .accessibilityLabel("Digite a data do seu aniversario")
    }
}

// ------ Define Campo de Email
extension SignUpView{
    var emailView: some View{
        EditTextView(placeholder: "Email",
                     text: $viewModel.email,
                     error: "Email Inválido",
                     failure: !viewModel.email.isEmail(), color: Color("dark"))
        .accessibilityLabel("Digite seu email")
    }
}

// ------ Define Campo de Senha
extension SignUpView{
    var passView: some View{
        EditTextView(placeholder: "Senha",
                     text: $viewModel.password,
                     error: "8 caracter, 1 letra maiúscula e 1 número.",
                     failure: !viewModel.password.isPassword(), color: Color("dark"), isSecure: true)
        .accessibilityLabel("Digite sua senha - 8 caracter, 1 letra maiúscula e 1 número")
    }
}

// ------ Define Button de Concluir
extension SignUpView {
    var signUpButton: some View{
        ButtonStyle(action: {
            viewModel.createUser()
            alerta(message: "Cadastro realizado com sucesso")
        }, text: "Concluir",
                    disabled: viewModel.validateForms(),
                    showProgress: self.viewModel.uiState == SignUpUIState.loading, color: Color("baron"))
        .accessibilityLabel("Botao concluir cadastro")
    }
}

extension SignUpView{
    func alerta(message: String) {
        
        let alert = UIAlertController(title: "Cadastro", message: message, preferredStyle: .alert)
            
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            dismiss()
        }
        alert.addAction(okAction)
        
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            viewController.present(alert, animated: true, completion: nil)
        }
        
    } //fim alert
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: SignUpViewModel())
    }
}
