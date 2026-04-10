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
    @Published var profile: ProfileData?
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""

    var isLoading: Bool {
        if case .loading = state { return true }
        return false
    }

    var imageURL: URL? {
        guard let path = profile?.profileImage, !path.isEmpty,
              let base = Bundle.main.object(forInfoDictionaryKey: APIKey.imageBaseURL) as? String else { return nil }
        return URL(string: "\(base)/\(path)")
    }

    var selectedCityValue: String {
        CityData.all.first(where: { $0.key == profile?.city })?.value ?? "Bakı"
    }

    private let manager: ProfileServiceProtocol

    init(manager: ProfileServiceProtocol = ProfileManager()) {
        self.manager = manager
    }

    @MainActor
    func loadProfile() async {
        state = .loading
        do {
            profile = try await manager.fetchProfile()
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
        guard let profile else { return }
        guard !profile.firstName.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertMessage = "Ad boş ola bilməz"
            showAlert = true
            return
        }
        guard !profile.lastName.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertMessage = "Soyad boş ola bilməz"
            showAlert = true
            return
        }
        Task {
            do {
                try await manager.updateProfile(profile)
                alertMessage = "Məlumatlar yadda saxlanıldı"
            } catch {
                alertMessage = (error as? NetworkError)?.errorDescription ?? error.localizedDescription
            }
            showAlert = true
        }
    }
}
