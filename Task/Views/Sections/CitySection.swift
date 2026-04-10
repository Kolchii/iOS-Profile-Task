//
//  CitySection.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import SwiftUI

struct CitySection: View {
    @Binding var selectedCityKey: String
    let selectedCityValue: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Yaşadığınız şəhər")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.primary)
            Menu {
                ForEach(CityData.all, id: \.key) { city in
                    Button(city.value) {
                        selectedCityKey = city.key
                    }
                }
            } label: {
                HStack {
                    Text(selectedCityValue)
                        .font(.system(size: 15))
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.system(size: 13))
                        .foregroundColor(Color(.systemGray))
                }
                .padding(.bottom, 8)
            }
            .accessibilityLabel("Şəhər seçimi")
            Divider()
        }
    }
}
