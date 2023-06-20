//
//  SignUpView.swift
//  Rangoo
//
//  Created by Rangoo Group on 13/06/23.
//

import SwiftUI
import Combine

struct SignUpView: View {
    
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
                    
                        Spacer(minLength: 5)
                        VStack(alignment: .center, spacing: 10){
                            
                            Text("Cadastre-se")
                                .foregroundColor(.black)
                                .font(.system(size: 40))
                                .font(.title.bold())
                                .padding(.vertical, 15)
                            
                            fullNameView
                            phoneView
                            addressView
                            birthdayView
                            emailView
                            passView
                            
                            
                            
                        }   // End VStack Interna
                        
                        Spacer(minLength: 10)
                        signUpButton
                        Text("ou")
                        signUpWithGoogle
                        
                        
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
    }
}

// ------ Define Campo de Contato
extension SignUpView{
    var phoneView: some View {
        EditTextView(placeholder: "Contato",
                     text: $viewModel.phone,
                     error: "Contato Inválido",
                     failure: !viewModel.phone.isPhoneNumber(), color: Color("dark"))
    }
}

// ------ Define Campo de Endereco
extension SignUpView{
    var addressView: some View {
        EditTextView(placeholder: "Endereço",
                     text: $viewModel.address,
                     error: "Endereço Inválido",
                     failure: !viewModel.address.isEmpty, color: Color("dark"))
    }
}

// ------ Define Campo de Aniversario
extension SignUpView{
    var birthdayView: some View{
       EditTextView(placeholder: "Aniversário",
                    text: $viewModel.birthday,
                     error: "Data Inválida",
                     failure: !viewModel.birthday.isDate(), color: Color("dark"))
    }
}

// ------ Define Campo de Email
extension SignUpView{
    var emailView: some View{
        EditTextView(placeholder: "Email",
                     text: $viewModel.email,
                     error: "Email Inválido",
                     failure: !viewModel.email.isEmail(), color: Color("dark"))
    }
}

// ------ Define Campo de Senha
extension SignUpView{
    var passView: some View{
        EditTextView(placeholder: "Senha",
                     text: $viewModel.password,
                     error: "Senha Inválida",
                     failure: !viewModel.password.isPassword(), color: Color("dark"))
    }
}

// ------ Define Button de Concluir
extension SignUpView {
    var signUpButton: some View{
        ButtonStyle(action: {},
                    text: "Concluir")
    }
}

// ------ Define Button de Concluir
extension SignUpView {
    var signUpWithGoogle: some View{
        ButtonStyle(action: {},
                    text: "Cadastre-se com Google", icon: "google_icon")
    }
}



struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: SignUpViewModel())
    }
}
