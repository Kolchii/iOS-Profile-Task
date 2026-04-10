//
//  NetworkProtocol.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import Foundation

protocol NetworkProtocol {
    func request<T: Decodable>(url: URL, method: HTTPMethod, body: [String: String]?) async throws -> T
    func request(url: URL, method: HTTPMethod, body: [String: String]) async throws
}

extension NetworkProtocol {
    func request<T: Decodable>(url: URL) async throws -> T {
        try await request(url: url, method: .get, body: nil)
    }
}
