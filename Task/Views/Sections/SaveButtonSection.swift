//
//  SaveButtonSection.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import SwiftUI

struct SaveButtonSection: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Yadda saxla")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(Color(red: 0.094, green: 0.467, blue: 0.949))
                .clipShape(RoundedRectangle(cornerRadius: 26))
        }
        .padding(.horizontal, 16)
        .accessibilityLabel("Məlumatları yadda saxla")
    }
}
