//
//  DashboardView.swift
//  AjmeraTask
//
//  Created by Vikram Kumar on 09/02/25.
//

import SwiftUI

struct DashboardView: View {
    
    @State private var fullname: String = ""
    @State private var gotoLogin: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Dashboard")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                
                Spacer()
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 20)
            
            VStack {
                Spacer()
                Text("Welcome to My App")
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .padding(.top, 10)
                
                Text("Fullname: **\(fullname)**")
                    .font(.footnote)
                    .foregroundColor(Color.black)
                Spacer()
                
                Button("Sign Out") {
                    UserDefaults.standard.removeObject(forKey: "userData")
                    gotoLogin = true
                }
            }
            
            Spacer()
        }
        .navigationDestination(isPresented: $gotoLogin) {
            LoginView()
        }
        .toolbarVisibility(.hidden)
        .onAppear() {
            if let userData = UserDefaults.standard.data(forKey: "userData"), let user = try? JSONDecoder().decode(User.self, from: userData) {
                fullname = user.fullName ?? "Unknown"
            } else {
                fullname = "Unknown"
            }
        }
    }
}

#Preview {
    DashboardView()
}
