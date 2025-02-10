//
//  LoginView.swift
//  AjmeraTask
//
//  Created by Vikram Kumar on 09/02/25.
//

import SwiftUI
import CoreData

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    @State private var animateOffset = false
    @State private var animateAlpha = false
    @State private var gotoSignup = false
    @State private var gotoDashboard = false
    

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
                            .padding(.top, 78)
                            .offset(y: animateOffset ? 0 : (UIScreen.main.bounds.height/2-103))
                            .animation(.easeInOut, value: animateOffset)
                        Spacer()
                    }
                    
                    VStack {
                        HStack {
                            Spacer()
                            VStack(spacing: 0) {
                                Text("Welcome Back")
                                    .fontWeight(.bold)
                                
                                Text("Sign In To Your Account")
                                    .font(.system(size: 14, weight: .regular))
                                    .padding(.top, 2)
                            }
                            .foregroundColor(.primary)
                            Spacer()
                        }
                        .padding(.top, 70)
                        .opacity(animateAlpha ? 1 : 0)
                        .animation(.easeInOut(duration: 0.4), value: animateAlpha)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            AppTextField(label: "Email address", value: $viewModel.email, keyboardType: .emailAddress)
                                .accessibilityLabel("emailTextField")
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .padding(.bottom, 22)
                                .opacity(animateAlpha ? 1 : 0)
                                .animation(.easeInOut(duration: 1.0), value: animateAlpha)
                            
                            AppTextField(label: "Password", value: $viewModel.password, isSecure: true)
                            .accessibilityLabel("passwordTextField")
                            .opacity(animateAlpha ? 1 : 0)
                            .animation(.easeInOut(duration: 1.5), value: animateAlpha)
                        }
                        .padding(.top, 72)
                        
                        Button {
                            Task {
                                let status = await viewModel.performLogin()
                                if status {
                                    gotoDashboard = true
                                }
                            }
                        } label: {
                            Text(viewModel.isLogging ? "Signing..." : "Login")
                        }
                        .buttonStyle(AppButtonStyle())
                        .padding(.top, 30)
                        .accessibilityLabel("loginButton")
                        .opacity(animateAlpha ? 1 : 0)
                        .animation(.easeInOut(duration: 2.0), value: animateAlpha)
                        .animation(.default, value: viewModel.isInputValid)
                        .disabled(!viewModel.isInputValid)
                        .disabled(viewModel.isLogging)
                        
                        HStack {
                            Spacer()
                            Text("Don't have an account?")
                                .foregroundColor(.primary)
                                .font(.system(size: 16, weight: .regular))
                            
                            Button {
                                gotoSignup = true
                            } label: {
                                Text("Register")
                                    .underline()
                            }
                            .buttonStyle(.plain)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.primary)
                            .accessibilityLabel("registerButton")
                            Spacer()
                        }
                        .opacity(animateAlpha ? 1 : 0)
                        .animation(.easeInOut(duration: 2.2), value: animateAlpha)
                        .padding(.top, 20)
                    }
                }
                .padding(.horizontal, 25)
            }
        }
        .toolbarVisibility(.hidden)
        .navigationDestination(isPresented: $gotoSignup) {
            SignUpView()
        }
        .navigationDestination(isPresented: $gotoDashboard) {
            DashboardView()
        }
        .onAppear {
            withAnimation {
                animateOffset = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    animateAlpha = true
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
