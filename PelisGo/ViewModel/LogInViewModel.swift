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
    @Published var logInStatus: LogInStatus = .success
    @Published var logInFields: LogInFields = LogInFields()
    func fieldsTrue() {
        print("All value true")
        logInFields.userEdited = true
        logInFields.passwordEdited = true
    }
    func logIn() {
        if (logInFields.user == "Admin") && (logInFields.password == "Password*123") {
            self.logInStatus = .success
        } else {
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
