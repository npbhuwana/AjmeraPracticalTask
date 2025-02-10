//
//  LoginViewModel.swift
//  AjmeraTask
//
//  Created by Vikram Kumar on 09/02/25.
//

import Foundation

@MainActor
class LoginViewModel: ObservableObject {
 
    @Published var email: String = "" {
        didSet {
            isInputValid = checkIsInputValid()
        }
    }
    @Published var password: String = "" {
        didSet {
            isInputValid = checkIsInputValid()
        }
    }
    @Published var isInputValid: Bool = false
    @Published var isLogging: Bool = false
   
    func performLogin() async -> Bool {
        
        Utility.dismissKeyboard()
        guard let url = URL(string: "https://ajmera.free.beeceptor.com/api/signin") else { return false }
        
        isLogging = true
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = try JSONSerialization.data(withJSONObject: ["email": email, "password": password], options: [])
            let (data, _) = try await URLSession.shared.data(for: request)
            isLogging = false
            
            let model = try JSONDecoder().decode(LoginModel.self, from: data)
            
            if model.type == "success" {
                if let usr = model.user, let userData = try? JSONEncoder().encode(usr) {
                    UserDefaults.standard.set(userData, forKey: "userData")
                }
                return true
            } else {
                Alert.showAlert(title: "Error", message: "Something went wrong. Please try again")
            }
        } catch {
            print(error)
            isLogging = false
            Alert.showAlert(title: "Error", message: error.localizedDescription)
        }
        return false
    }
    
    func checkIsInputValid() -> Bool {
        if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        } else if !Utility.isValidEmail(email: self.email) {
            return false
        } else if password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        
        return true
    }
}
