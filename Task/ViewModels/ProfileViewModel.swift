//
//  ProfileViewModel.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import SwiftUI
import Combine

final class ProfileViewModel: ObservableObject {
    @Published var profile: ProfileData?
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var gender: String = "MALE"
    @Published var selectedCityKey: String = "BAKI"
    @Published var birthDate: Date = Date()
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""

    @MainActor
    func loadProfile() async {
        isLoading = true
        do {
            let data = try await NetworkService.shared.fetchProfile()
            self.profile = data
            self.firstName = data.firstName
            self.lastName = data.lastName
            self.gender = data.gender
            self.selectedCityKey = data.city
            self.birthDate = parseDate(data.birthDate)
        } catch {
            alertMessage = "Məlumatlar yüklənmədi: \(error.localizedDescription)"
            showAlert = true
        }
        isLoading = false
    }

    @MainActor
    func saveProfile() {
        guard !firstName.trimmingCharacters(in: .whitespaces).isEmpty,
              !lastName.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertMessage = "Ad və soyad boş ola bilməz"
            showAlert = true
            return
        }
        alertMessage = "Məlumatlar yadda saxlanıldı"
        showAlert = true
    }

    private func parseDate(_ string: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: string) ?? Date()
    }
}
