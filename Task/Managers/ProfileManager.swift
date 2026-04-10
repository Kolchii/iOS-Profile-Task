//
//  ProfileManager.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import Foundation

final class ProfileManager: NetworkServiceProtocol {
    private let networkHelper = NetworkHelper()

    private let baseURL: String = {
        // Base URL, Config.xcconfig faylında saxlanılır və Info.plist vasitəsilə oxunur.
        // Həssas məlumatların GitHub-da görünməməsi üçün bu yanaşma istifadə edilib.
        // Config.xcconfig faylı .gitignore-a əlavə edilib və repoda mövcud deyil.
        Bundle.main.object(forInfoDictionaryKey: APIKey.baseURL) as? String ?? ""
    }()

    func fetchProfile() async throws -> ProfileData {
        guard let url = URL(string: "\(baseURL)/getProfile") else {
            throw NetworkError.invalidURL
        }
        let response: ProfileResponse = try await networkHelper.request(url: url)
        return response.data
    }

    func updateProfile(firstName: String, lastName: String, gender: String, city: String, birthDate: String) async throws {
        guard let url = URL(string: "\(baseURL)/updateProfile") else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: String] = [
            "firstName": firstName,
            "lastName": lastName,
            "gender": gender,
            "city": city,
            "birthDate": birthDate
        ]
        request.httpBody = try JSONEncoder().encode(body)
        let (_, _) = try await URLSession.shared.data(for: request)
    }
}
