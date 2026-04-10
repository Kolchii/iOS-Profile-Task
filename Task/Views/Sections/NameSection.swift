//
//  NameSection.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import SwiftUI

struct NameSection: View {
    @Binding var firstName: String
    @Binding var lastName: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Adınız")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.primary)
            TextField("Ad soyad", text: Binding(
                get: {
                    "\(firstName) \(lastName)"
                        .trimmingCharacters(in: .whitespaces)
                },
                set: { val in
                    let parts = val.split(separator: " ", maxSplits: 1)
                    firstName = parts.first.map(String.init) ?? ""
                    lastName = parts.dropFirst().first.map(String.init) ?? ""
                }
            ))
            .font(.system(size: 15))
            .foregroundColor(.primary)
            .padding(.bottom, 8)
            .accessibilityLabel("Ad və soyad")
            Divider()
        }
    }
}
