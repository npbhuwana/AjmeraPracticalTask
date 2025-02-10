//
//  LoginModel.swift
//  AjmeraTask
//
//  Created by Vikram Kumar on 10/02/25.
//

// MARK: - LoginModel
struct LoginModel: Codable {
    let type: String?
    let user: User?
}

// MARK: - User
struct User: Codable {
    let fullName, email: String?
}
