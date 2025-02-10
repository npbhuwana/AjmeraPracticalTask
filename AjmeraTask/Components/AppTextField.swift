//
//  AppTextField.swift
//  AjmeraTask
//
//  Created by Vikram Kumar on 09/02/25.
//

import SwiftUI

struct AppTextField: View {
    var label: String
    var placeholder: String? = nil
    @Binding var value: String
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(self.label)
                .foregroundColor(.primary)
                .font(.system(size: 16, weight: .regular))
                .padding(.bottom, 6)
            
            HStack(spacing: 0) {
                if isSecure {
                    SecureField(placeholder ?? label, text: $value)
                        .focused($isFocused)
                        .keyboardType(keyboardType)
                        .foregroundColor(.primary)
                        .font(.system(size: 14, weight: .regular))
                        .padding([.vertical, .leading])
                        
                }else {
                    TextField(placeholder ?? label, text: $value)
                        .focused($isFocused)
                        .keyboardType(keyboardType)
                        .foregroundColor(.primary)
                        .font(.system(size: 14, weight: .regular))
                        .padding([.vertical, .leading])
                        
                }
            }
            .frame(height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.primary)
                    .animation(.default, value: isFocused)
            )
        }
        
    }
}

#Preview {
    AppTextField(label: "Email Address", value: .constant(""), isSecure: false)
}
