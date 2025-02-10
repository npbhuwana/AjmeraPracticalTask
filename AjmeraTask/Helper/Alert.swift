//
//  Alert.swift
//  AjmeraTask
//
//  Created by Vikram Kumar on 09/02/25.
//

import Foundation
import UIKit

class Alert {
    
    static func showAlert(title: String = "Alert", message: String, _ completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                completion?()
            }
            alertController.addAction(okAction)
            
            let topController = UIApplication.shared.windows.last?.rootViewController
            topController?.present(alertController, animated: true, completion: nil)
        }
    }
}
