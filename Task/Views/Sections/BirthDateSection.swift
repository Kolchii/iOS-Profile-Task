//
//  BirthDateSection.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import SwiftUI

struct BirthDateSection: View {
    @Binding var birthDate: Date?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Doğum tarixi")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.primary)
            HStack {
                Text(birthDate.map { formatDate($0) } ?? "Doğum tarixi")
                    .font(.system(size: 15))
                    .foregroundColor(birthDate == nil ? .gray : .primary)
                Spacer()
                Image(systemName: "calendar")
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 14)
            .frame(height: 50)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                DatePicker(
                    "",
                    selection: Binding(
                        get: { birthDate ?? Date() },
                        set: { birthDate = $0 }
                    ),
                    displayedComponents: .date
                )
                .datePickerStyle(.compact)
                .labelsHidden()
                .opacity(0.015)
            }
        }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
}
