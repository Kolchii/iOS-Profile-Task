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
                    "",
                    selection: $birthDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.compact)
                .labelsHidden()
                .accessibilityLabel("Doğum tarixi seçimi")
                Spacer()
            }
            .padding(.bottom, 8)
            Divider()
        }
    }
}
