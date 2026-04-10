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

struct NetworkHelper {
    static func request<T: Decodable>(url: URL) async throws -> T {
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

    static func requestWithBody(url: URL, method: String, body: [String: String]) async throws {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)
        let (_, _) = try await URLSession.shared.data(for: request)
    }
}
