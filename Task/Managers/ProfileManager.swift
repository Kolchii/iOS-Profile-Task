//
//  ProfileManager.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import Foundation

final class ProfileManager: ProfileServiceProtocol {
    private let networkHelper: NetworkProtocol

    init(networkHelper: NetworkProtocol = NetworkHelper()) {
        self.networkHelper = networkHelper
    }

    // BASE_URL dəyəri Config.xcconfig faylında saxlanılır və Info.plist vasitəsilə oxunur.
    // Config.xcconfig həssas məlumat olduğu üçün .gitignore-a əlavə edilib və repoda yoxdur.
    // Layihəni işə salmaq üçün Task/Config/Config.xcconfig faylını yaradıb BASE_URL dəyərini əlavə edin.
    private let baseURL: String = {
        Bundle.main.object(forInfoDictionaryKey: APIKey.baseURL) as? String ?? ""
    }()

    func fetchProfile() async throws -> ProfileData {
        guard let url = URL(string: "\(baseURL)/getProfile") else {
            throw NetworkError.invalidURL
        }
        let response: ProfileResponse = try await networkHelper.request(url: url)
        return response.data
    }

    func updateProfile(_ data: ProfileData) async throws {
        guard let url = URL(string: "\(baseURL)/updateProfile") else {
            throw NetworkError.invalidURL
        }
        let body: [String: String] = [
            "firstName": data.firstName,
            "lastName": data.lastName,
            "gender": data.gender.rawValue,
            "city": data.city,
            "birthDate": DateFormatter.profileDate.string(from: data.birthDate)
        ]
        try await networkHelper.request(url: url, method: .put, body: body)
    }
}
