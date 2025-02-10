//
//  SignUpViewModel.swift
//  AjmeraTask
//
//  Created by Vikram Kumar on 09/02/25.
//

import SwiftUI

@MainActor
class SignUpViewModel: ObservableObject {
 
    
    @Published var fullname: String = "" {
        didSet {
            isInputValid = checkIsInputValid()
        }
    }
    
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
    @Published var confirmPassword: String = "" {
        didSet {
            isInputValid = checkIsInputValid()
        }
    }
    
    @Published var birthday: Date = Date() {
        didSet {
            isInputValid = checkIsInputValid()
        }
    }
    @Published var gender: String = "Male" {
        didSet {
            isInputValid = checkIsInputValid()
        }
    }
    
    @Published var isInputValid: Bool = false
    @Published var isLoading: Bool = false
   
    func performSignUp() async -> Bool {
        
        Utility.dismissKeyboard()
        guard let url = URL(string: "https://ajmera.free.beeceptor.com/api/signup") else { return false }
        
        isLoading = true
        
        do {
            var params = [String: Any]()
            params["fullname"] = fullname
            params["email"] = email
            params["password"] = password
            params["confirmPassword"] = confirmPassword
            params["birthday"] = birthday.formatted(date: .numeric, time: .omitted)
            params["gender"] = gender
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            let (data, _) = try await URLSession.shared.data(for: request)
            
            isLoading = false
            let model = try JSONDecoder().decode(SignupModel.self, from: data)
            
            if model.success == true {
                return true
            } else {
                Alert.showAlert(title: "Error", message: "Something went wrong. Please try again")
            }
        } catch {
            print(error)
            isLoading = false
            Alert.showAlert(title: "Error", message: error.localizedDescription)
        }
        return false
    }
    
    func checkIsInputValid() -> Bool {
        
        
        
        if fullname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        } else if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        } else if !Utility.isValidEmail(email: self.email) {
            return false
        } else if password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        } else if !Utility.validatePassword(self.password) {
            return false
        } else if password != confirmPassword {
            return false
        } else if !checkIsBirthdayValid() {
            return false
        }
        
        return true
    }
    
    func checkIsBirthdayValid() -> Bool {
        let dateDifferenceInYears = Calendar.current.dateComponents([.year], from: birthday, to: Date()).year ?? 0
        return dateDifferenceInYears >= 18
    }
}
