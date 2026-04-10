//
//  ProfileViewModel.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import SwiftUI
import Combine
final class ProfileViewModel: ObservableObject {
    @Published var state: ViewState = .idle
    @Published var profileImagePath: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var gender: Gender = .male
    @Published var selectedCityKey: String = "BAKI"
    @Published var birthDate: Date? = nil
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""

    var isLoading: Bool {
        if case .loading = state { return true }
        return false
    }

    var imageURL: URL? {
        guard !profileImagePath.isEmpty,
              let base = Bundle.main.object(forInfoDictionaryKey: APIKey.imageBaseURL) as? String else { return nil }
        return URL(string: "\(base)/\(profileImagePath)")
    }

    var selectedCityValue: String {
        CityData.all.first(where: { $0.key == selectedCityKey })?.value ?? "Bakı"
    }

    private let manager: NetworkServiceProtocol

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    init(manager: NetworkServiceProtocol = ProfileManager()) {
        self.manager = manager
    }

    @MainActor
    func loadProfile() async {
        state = .loading
        do {
            let data = try await manager.fetchProfile()
            self.profileImagePath = data.profileImage
            self.firstName = data.firstName
            self.lastName = data.lastName
            self.gender = data.gender
            self.selectedCityKey = data.city
            self.birthDate = parseDate(data.birthDate)
            state = .success
        } catch {
            let message = (error as? NetworkError)?.errorDescription ?? error.localizedDescription
            state = .failure(message)
            alertMessage = message
            showAlert = true
        }
    }

    @MainActor
    func saveProfile() {
        guard !firstName.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertMessage = "Ad boş ola bilməz"
            showAlert = true
            return
        }
        guard !lastName.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertMessage = "Soyad boş ola bilməz"
            showAlert = true
            return
        }
        guard let birthDate else {
            alertMessage = "Doğum tarixi seçilməyib"
            showAlert = true
            return
        }
        Task {
            do {
                try await manager.updateProfile(
                    firstName: firstName,
                    lastName: lastName,
                    gender: gender.rawValue,
                    city: selectedCityKey,
                    birthDate: formatDate(birthDate)
                )
                alertMessage = "Məlumatlar yadda saxlanıldı"
            } catch {
                alertMessage = (error as? NetworkError)?.errorDescription ?? error.localizedDescription
            }
            showAlert = true
        }
    }

    private func parseDate(_ string: String) -> Date {
        Self.dateFormatter.date(from: string) ?? Date()
    }

    private func formatDate(_ date: Date) -> String {
        Self.dateFormatter.string(from: date)
    }
}
