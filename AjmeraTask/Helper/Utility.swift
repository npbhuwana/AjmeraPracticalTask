//
//  Utility.swift
//  AjmeraTask
//
//  Created by Vikram Kumar on 09/02/25.
//

import Foundation
import UIKit

class Utility {
    
    
    static func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func validatePassword(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&+=*!_?<>.,;:-]).{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func dismissKeyboard() {
        UIApplication.shared.windows.first?.endEditing(true)
    }
}
