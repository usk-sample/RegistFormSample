//
//  ViewModel.swift
//  LoginFormSample
//
//  Created by Yusuke Hasegawa on 2021/06/04.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    
    @Published var mail = ""
    @Published var pass = ""
    @Published var retype = ""
    
    @Published var canSend = false
    @Published var invalidMail = ""
    @Published var invalidPass = ""

    private var subscriptions: Set<AnyCancellable> = .init()
    
    init() {
        
        let mailValidation = $mail.map({ !$0.isEmpty && $0.isValidEmail }).eraseToAnyPublisher()
        let passValidation = $pass.map({ !$0.isEmpty }).eraseToAnyPublisher()
        let retypeValidation = $retype.map({ !$0.isEmpty }).eraseToAnyPublisher()
        let matchValidation = $pass.combineLatest($retype).map({ $0 == $1 }).eraseToAnyPublisher()
        
        Publishers.CombineLatest4(mailValidation, passValidation, retypeValidation, matchValidation)
            .map({ [$0.0, $0.1, $0.2, $0.3] })
            .map({ $0.allSatisfy{ $0 } })
            .assign(to: &$canSend)
        
        $mail.map({ $0.isEmpty || $0.isValidEmail ? "" : "enter valid mail address" }).assign(to: &$invalidMail)
        
        $pass.combineLatest($retype)
            .filter({ !$0.1.isEmpty && !$0.1.isEmpty })
            .map({ $0.0 == $0.1 ? "" : "must match password" })
            .assign(to: &$invalidPass)
                
    }
    
}

extension String {
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
     }
    
}
