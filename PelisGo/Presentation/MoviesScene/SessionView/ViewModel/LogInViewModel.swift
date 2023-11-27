//
//  LogInViewModel.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 24/11/23.
//

import Foundation

enum LogInStatus {
    case success
    case fail
}

class LogInViewModel: ObservableObject {
    @Published var logInStatus: LogInStatus = .fail
    @Published var logInFields: LogInFields = LogInFields()
    
    private let logInUseCase: LogInUseCase
    
    init(logInUseCase: LogInUseCase) {
        self.logInUseCase = logInUseCase
    }
    
    func fieldsTrue() {
        print("All value true")
        logInFields.userEdited = true
        logInFields.passwordEdited = true
    }
    
    func logIn() {
        logInUseCase.logIn(user: logInFields.user, password: logInFields.password) { [weak self] result in
            DispatchQueue.main.async {
                self?.handleLogInResult(result)
            }
        }
    }
    
    private func handleLogInResult(_ result: LogInStatus) {
        switch result {
        case .success:
            self.logInStatus = .success
        case .fail:
            logInFields.errorLogIn = "Usuario o Contraseña incorrectos"
        }
    }
    
    func logOut() {
        logInStatus = .fail
    }
    
}

class LogInFields {
    var user: String = "Admin"
    var userEdited: Bool = false
    var userError: String {
        if user == "" && userEdited {
            return "Nombre de producto no válido"
        } else {
            return ""
        }
    }
    var password: String = "Password*123"
    var passwordEdited: Bool = false
    var passwordError: String {
        if self.password == "" && self.passwordEdited {
            return "Contraseña no válido"
        } else {
            return ""
        }
    }
    var errorLogIn: String = ""
}
