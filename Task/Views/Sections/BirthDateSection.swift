//
//  BirthDateSection.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import SwiftUI

struct BirthDateSection: View {
    @Binding var birthDate: Date?
    @State private var showDatePicker = false

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
                Image("calendar-2")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.systemGray2))
            }
            .padding(.horizontal, 14)
            .frame(height: 50)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .onTapGesture {
                showDatePicker.toggle()
            }

            if showDatePicker {
                DatePicker(
                    "",
                    selection: Binding(
                        get: { birthDate ?? Date() },
                        set: {
                            birthDate = $0
                            showDatePicker = false
                        }
                    ),
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()

    private func formatDate(_ date: Date) -> String {
        Self.dateFormatter.string(from: date)
    }
}
