//
//  GenderSection.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import SwiftUI

struct GenderSection: View {
    @Binding var gender: Gender

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Cinsiniz")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.primary)
            Menu {
                Button("Kişi") { gender = .male }
                Button("Qadın") { gender = .female }
            } label: {
                HStack {
                    Text(gender == .male ? "Kişi" : "Qadın")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 14)
                .frame(height: 50)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}
