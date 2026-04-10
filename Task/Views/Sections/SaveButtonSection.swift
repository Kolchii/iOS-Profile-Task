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
                .padding(.vertical, 16)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        }
        .accessibilityLabel("Məlumatları yadda saxla")
        .padding(.top, 8)
    }
}
