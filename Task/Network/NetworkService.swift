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

protocol NetworkServiceProtocol {
    func fetchProfile() async throws -> ProfileData
    func updateProfile(firstName: String, lastName: String, gender: String, city: String, birthDate: String) async throws
}

final class NetworkService: NetworkServiceProtocol {
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
