//
//  BirthDateSection.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import SwiftUI

struct BirthDateSection: View {
    @Binding var birthDate: Date
    @State private var showDatePicker = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Doğum tarixi")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.primary)
            HStack {
                Text(formatDate(birthDate))
                    .font(.system(size: 15))
                    .foregroundColor(.primary)
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
                    selection: $birthDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onChange(of: birthDate) { _ in
                    showDatePicker = false
                }
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
