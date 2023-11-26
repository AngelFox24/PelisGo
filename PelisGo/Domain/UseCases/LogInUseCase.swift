//
//  LogInUseCase.swift
//  PelisGo
//
//  Created by Angel Curi Laurente on 25/11/23.
//

import Foundation

protocol LogInUseCase {
    func logIn(user: String, password: String, completion: @escaping (LogInStatus) -> Void)
}

final class LogInInteractor: LogInUseCase {
    func logIn(user: String, password: String, completion: @escaping (LogInStatus) -> Void) {
        if (user == "Admin") && (password == "Password*123") {
            completion(.success)
        } else {
            completion(.fail)
        }
    }
}
