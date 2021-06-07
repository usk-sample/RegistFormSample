//
//  ContentView.swift
//  LoginFormSample
//
//  Created by Yusuke Hasegawa on 2021/06/04.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ViewModel = .init()
    
    var body: some View {
        VStack {
            Group {
                TextField.init("mail address", text: self.$viewModel.mail)                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                if !self.viewModel.invalidMail.isEmpty {
                    Text(self.viewModel.invalidMail)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
            }
  
            Group {
                SecureField.init("password", text: self.$viewModel.pass)
                    .textContentType(.newPassword)

                SecureField.init("retype password", text: self.$viewModel.retype)
                    .textContentType(.newPassword)

                if !self.viewModel.invalidPass.isEmpty {
                    Text(self.viewModel.invalidPass)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
            }
            
            Button("Register") {
                debugPrint("register")
            }.disabled(!self.viewModel.canSend)
            .foregroundColor(.blue)
            
            Spacer()
            
        }.padding()        
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init())        
    }
}
