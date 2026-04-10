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
                .font(.system(size: 14, weight: .medium))
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
