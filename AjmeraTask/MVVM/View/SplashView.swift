//
//  SplashView.swift
//  AjmeraTask
//
//  Created by Vikram Kumar on 10/02/25.
//

import SwiftUI

struct SplashView: View {
    
    @State private var viewScale = 0.0
    @State private var gotoDashboard: Bool = false
    @State private var gotoLogin: Bool = false
    
    var body: some View {
        
        VStack {
            Spacer()
            
            Image("ajmera_logo")
                .resizable()
                .scaledToFit()
                .frame(height: 50)
                .opacity(viewScale)
                .scaleEffect(viewScale)
                .animation(.spring(), value: viewScale)
            
            Spacer()
        }
        .navigationDestination(isPresented: $gotoLogin) {
            LoginView()
        }
        .navigationDestination(isPresented: $gotoDashboard) {
            DashboardView()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation {
                    viewScale = 1
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                if UserDefaults.standard.value(forKey: "userData") != nil {
                    gotoDashboard = true
                } else {
                    gotoLogin = true
                }
            }
        }
    }
}
