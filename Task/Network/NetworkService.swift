//
//  NetworkService.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case decodingError
    case serverError(Int)
    case noInternet

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Yanlış URL"
        case .decodingError: return "Data oxunmadı"
        case .serverError(let code): return "Server xətası: \(code)"
        case .noInternet: return "İnternet bağlantısı yoxdur"
        }
    }
}

protocol NetworkServiceProtocol {
    func fetchProfile() async throws -> ProfileData
    func updateProfile(firstName: String, lastName: String, gender: String, city: String, birthDate: String) async throws
}

final class NetworkService: NetworkServiceProtocol {
    private let baseURL: String = {
        Bundle.main.object(forInfoDictionaryKey: APIKey.baseURL) as? String ?? ""
    }()

    func fetchProfile() async throws -> ProfileData {
        guard let url = URL(string: "\(baseURL)/getProfile") else {
            throw NetworkError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            let code = (response as? HTTPURLResponse)?.statusCode ?? 0
            throw NetworkError.serverError(code)
        }
        do {
            let decoded = try JSONDecoder().decode(ProfileResponse.self, from: data)
            return decoded.data
        } catch {
            throw NetworkError.decodingError
        }
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
        let (_, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            let code = (response as? HTTPURLResponse)?.statusCode ?? 0
            throw NetworkError.serverError(code)
        }
    }
}
