//
//  NetworkService.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import Foundation

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case serverError
}

final class NetworkService {
    static let shared = NetworkService()
    private init() {}
    private let baseURL: String = {
        Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
    }()
    func fetchProfile() async throws -> ProfileData {
        guard let url = URL(string: "\(baseURL)/getProfile") else {
            throw NetworkError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(ProfileResponse.self, from: data)
        return response.data
    }
}
