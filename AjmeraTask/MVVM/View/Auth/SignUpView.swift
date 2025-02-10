//
//  SignUpView.swift
//  AjmeraTask
//
//  Created by Vikram Kumar on 09/02/25.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject private var viewModel = SignUpViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var gotoLogin = false
    

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Spacer()
                        Image("ajmera_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                            .padding(.top,20)
                        Spacer()
                    }
                    
                    VStack {
                        HStack {
                            Text("Register")
                                .font(.system(size: 25, weight: .semibold))
                            .foregroundColor(.primary)
                            Spacer()
                        }
                        .padding(.top, 30)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            AppTextField(label: "Fullname", value: $viewModel.fullname)
                                .accessibilityLabel("fullnameTextField")
                                .autocapitalization(.words)
                                .padding(.bottom, 22)
                            
                            AppTextField(label: "Email address", value: $viewModel.email, keyboardType: .emailAddress)
                                .accessibilityLabel("emailTextField")
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .padding(.bottom, 22)
                            
                            AppTextField(label: "Password", value: $viewModel.password, isSecure: true)
                            .accessibilityLabel("passwordTextField")
                            .autocorrectionDisabled()
                            .padding(.bottom, 22)
                            
                            AppTextField(label: "Confirm Password", value: $viewModel.confirmPassword, isSecure: true)
                            .accessibilityLabel("confirmPasswordTextField")
                            .autocorrectionDisabled()
                            .padding(.bottom, 22)
                            
                            DatePicker("Birthday", selection: $viewModel.birthday, in: ...Date(), displayedComponents: .date)
                                .padding(.bottom, 22)
                            
                            HStack {
                                Text("Gender")
                                    .foregroundColor(.primary)
                                    .font(.system(size: 16, weight: .regular))
                                
                                Spacer()
                                Picker("", selection: $viewModel.gender) {
                                    ForEach(["Male", "Female", "Other"], id: \.self) { gender in
                                        Text(gender).tag(gender)
                                    }
                                }
                                .tint(.primary)
                            }
                        }
                        .padding(.top, 20)
                        
                        Button {
                            Task {
                                let status = await viewModel.performSignUp()
                                if status {
                                    Alert.showAlert(title: "Success", message: "Sign Up successful. Please log in") {
                                        dismiss()
                                    }
                                }
                            }
                        } label: {
                            Text(viewModel.isLoading ? "Signing Up..." : "Sign Up")
                        }
                        .buttonStyle(AppButtonStyle())
                        .padding(.top, 30)
                        .accessibilityLabel("signUpButton")
                        .animation(.default, value: viewModel.isInputValid)
                        .disabled(!viewModel.isInputValid)
                        .disabled(viewModel.isLoading)
                        
                        HStack {
                            Spacer()
                            Text("Already have an account?")
                                .foregroundColor(.primary)
                                .font(.system(size: 16, weight: .regular))
                            
                            Button {
                                dismiss()
                            } label: {
                                Text("Login")
                                    .underline()
                            }
                            .buttonStyle(.plain)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.primary)
                            .accessibilityLabel("loginButton")
                            Spacer()
                        }
                        .padding(.top, 20)
                    }
                }
                .padding(.horizontal, 25)
            }
        }
        .toolbarVisibility(.hidden)
    }
}

#Preview {
    SignUpView()
}
