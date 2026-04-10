//
//  BirthDateSection.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import SwiftUI

struct BirthDateSection: View {
    @Binding var birthDate: Date

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Doğum tarixi")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.primary)
            HStack {
                DatePicker(
                    "Doğum tarixi",
                    selection: $birthDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.compact)
                .labelsHidden()
                Spacer()
                Image(systemName: "calendar")
                    .foregroundColor(Color(.systemGray))
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}
