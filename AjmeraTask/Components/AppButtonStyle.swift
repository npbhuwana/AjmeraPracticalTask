//
//  AppButtonStyle.swift
//  AjmeraTask
//
//  Created by Vikram Kumar on 09/02/25.
//

import Foundation
import SwiftUI

struct AppButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(isEnabled ? Color.appTextSecondary : Color.appTextSecondary.opacity(0.8))
            .frame(height: 55)
            .font(.system(size: 18, weight: .semibold))
            .background(isEnabled ? Color.primary : Color.primary.opacity(0.3))
            .cornerRadius(8)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .shadow(color: .black.opacity(0.29), radius: 6, x: 0, y: 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
    
}
