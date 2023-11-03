//
//  PerfilView.swift
//  Rangoo
//
//  Created by coltec on 21/06/23.
//

import SwiftUI
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import UIKit

struct PerfilView: View {
    
    @ObservedObject var viewModel: PerfilViewModel
    @Binding var logado: Bool
    
    //@State private var imagem: String = ""
    weak var imagem: UIImageView!
    
    var body: some View {
        
        Group{
            switch viewModel.uiState{
                case .loading:
                    loadingView()
                case .error(let msg):
                    Text("erro \(msg)")

            }//fim switch
        }//fim group
        
    }//fim some view
}//fim View

extension PerfilView {
    func loadingView() -> some View{
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 10){
                
                //Exibe Imagem Logo
                Image("lucas")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 100, maxHeight: 100)
                    .padding(.horizontal, 10)
                    .background(Color.white)
                    .accessibilityLabel("Imagem da logo do aplicativo")
                
                
                VStack(alignment: .center){
                    
                    name_image
                    
                    VStack{
                        ZStack(alignment: .leadingFirstTextBaseline){
                            
                            email
                            birthday
                            address
                            phone
                        }
                    }
                    .frame(minHeight: 280)
                    // Fim VStack Dados
                    
                    
                }
                .frame(maxWidth: 300)
                .padding(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("soft26"), lineWidth: 3)
                )
                .background(Color("soft26"))
                
                VStack(alignment: .center, spacing: 10){
                    recuperarSenha
                    deslogaButton
                }
                .padding(20)
                // Fim VStack Interna
                
        
            }// Fim VStack externa
            .onAppear(perform: {
                viewModel.getUserData()
            })
        }
    }
}

extension PerfilView {
    var name_image: some View {
        VStack (alignment: .center, spacing: 10){
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(maxWidth: 100, maxHeight: 100)
                    .cornerRadius(5)
                    .aspectRatio(contentMode: .fit)
                    .padding(5)
                    .gesture(
                        TapGesture()
                            .onEnded{ _ in
                                viewModel.uptadeImage()
                            }
                    )
                    .accessibilityLabel("Imagem de perfil")
            }
            
            Text(viewModel.name)
                .font(.system(size: 25))
                .bold()
                .accessibilityLabel("Nome do usuário")
        }
    }
}

extension PerfilView {
    var email: some View {
        VStack(alignment: .leading, spacing: 5){
            Text("Email")
                .font(.system(size: 20))
                .bold()
                .accessibilityLabel("Email")
            
            Text(viewModel.email)
                .font(.system(size: 20))
                .accessibilityLabel("Email do usuário")
               
        }
        .offset(x: -70, y: -120)
    }
}

extension PerfilView {
    var birthday: some View {
        VStack(alignment: .leading, spacing: 5){
            Text("Data Nascimento")
                .font(.system(size: 20))
                .bold()
                .accessibilityLabel("Aniversário")
            
            Text(viewModel.birthday)
                .font(.system(size: 20))
                .accessibilityLabel("Aniversário do usuário")
               
        }
        .offset(x: -70, y: -50)
    }
}

extension PerfilView {
    var address: some View {
        VStack(alignment: .leading, spacing: 5){
            Text("Endereço")
                .font(.system(size: 20))
                .bold()
                .accessibilityLabel("Endereço")
            
            Text(viewModel.address)
                .font(.system(size: 20))
                .accessibilityLabel("Endereço do usuário")
            
        }
        .offset(x: -70, y: 20)
    }
}

extension PerfilView {
    var phone: some View {
        VStack(alignment: .leading, spacing: 5){
            Text("Contato")
                .font(.system(size: 20))
                .bold()
                .accessibilityLabel("Contato")
            
            Text(viewModel.phone)
                .font(.system(size: 20))
                .accessibilityLabel("Contato do usuário")
              
        }
        .offset(x: -70, y: 90)
    }
}


extension PerfilView {
    var recuperarSenha: some View{
        Button{
            viewModel.recuperaSenha { sucess in
                if sucess {
                    alert(message: "Uma mensagem de redefinicão foi enviada para o seu e-mail.")
                } else {
                    alert(message: "Erro ao enviar a mensagem de redefinicao.")
                }
            }
            
        } label: {
            Text("Recuperar Senha")
                .foregroundColor(Color("dark"))
                .font(.system(size: 18))
                .accessibilityLabel("Botão de recuperar senha")
        }
    }
}

extension PerfilView{
    func alert(message: String) {
        
        let alert = UIAlertController(title: "Redefinir senha", message: message, preferredStyle: .alert)
           
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in

        }
        alert.addAction(okAction)
        
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            viewController.present(alert, animated: true, completion: nil)
        }
        
    } //fim alert
}

extension PerfilView {
    var deslogaButton: some View{
        Button{
            viewModel.deslogaUsuario()
            self.logado = false
        } label: {
            Text("Deslogar")
                .foregroundColor(Color("baron"))
                .font(.system(size: 18))
                .accessibilityLabel("Botão de deslogar usuário")
        }
    }
}


struct PerfilView_Previews: PreviewProvider {
    static var previews: some View {
        PerfilView(viewModel: PerfilViewModel(), logado: .constant(true))
    }
}




