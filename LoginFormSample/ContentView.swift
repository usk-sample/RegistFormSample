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
        List {
            Group {
                TextField.init("mail address", text: self.$viewModel.mail)                    .textContentType(.emailAddress)
                if !self.viewModel.invalidMail.isEmpty {
                    Text(self.viewModel.invalidMail)
                }
  
                TextField.init("password", text: self.$viewModel.pass)
                    .textContentType(.newPassword)
                TextField.init("retype password", text: self.$viewModel.retype)
                    .textContentType(.newPassword)
            }
            Button.init("Register") {
                debugPrint("register")
            }.disabled(!self.viewModel.canSend)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
