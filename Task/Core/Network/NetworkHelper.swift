//
//  NetworkHelper.swift
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

final class NetworkHelper {
    func request<T: Decodable>(url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            let code = (response as? HTTPURLResponse)?.statusCode ?? 0
            throw NetworkError.serverError(code)
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
