//
//  ProfileManager.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import Foundation

final class ProfileManager: NetworkServiceProtocol {
    private let baseURL: String = {
        Bundle.main.object(forInfoDictionaryKey: APIKey.baseURL) as? String ?? ""
    }()

    func fetchProfile() async throws -> ProfileData {
        guard let url = URL(string: "\(baseURL)/getProfile") else {
            throw NetworkError.invalidURL
        }
        let response: ProfileResponse = try await NetworkHelper.request(url: url)
        return response.data
    }

    func updateProfile(firstName: String, lastName: String, gender: String, city: String, birthDate: String) async throws {
        guard let url = URL(string: "\(baseURL)/updateProfile") else {
            throw NetworkError.invalidURL
        }
        let body: [String: String] = [
            "firstName": firstName,
            "lastName": lastName,
            "gender": gender,
            "city": city,
            "birthDate": birthDate
        ]
        try await NetworkHelper.requestWithBody(url: url, method: "PUT", body: body)
    }
}
