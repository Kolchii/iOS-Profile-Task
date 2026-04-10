//
//  GenderSection.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import SwiftUI

struct GenderSection: View {
    @Binding var gender: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Cinsiniz")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.primary)
            Menu {
                Button("Kişi") { gender = "MALE" }
                Button("Qadın") { gender = "FEMALE" }
            } label: {
                HStack {
                    Text(gender == "MALE" ? "Kişi" : "Qadın")
                        .font(.system(size: 15))
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.system(size: 13))
                        .foregroundColor(Color(.systemGray))
                }
                .padding(.bottom, 8)
            }
            .accessibilityLabel("Cins seçimi")
            Divider()
        }
    }
}
