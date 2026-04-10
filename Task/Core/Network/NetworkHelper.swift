//
//  NetworkHelper.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import Foundation

final class NetworkHelper {
    private static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.profileDate)
        return decoder
    }()

    func request<T: Decodable>(url: URL, method: HTTPMethod = .get, body: [String: String]? = nil) async throws -> T {
        let data = try await execute(url: url, method: method, body: body)
        do {
            return try Self.decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }

    func request(url: URL, method: HTTPMethod, body: [String: String]) async throws {
        _ = try await execute(url: url, method: method, body: body)
    }

    private func execute(url: URL, method: HTTPMethod, body: [String: String]?) async throws -> Data {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        if let body {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(body)
        }
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            let code = (response as? HTTPURLResponse)?.statusCode ?? 0
            throw NetworkError.serverError(code)
        }
        return data
    }
}
