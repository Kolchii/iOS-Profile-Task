//
//  NetworkError.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case decodingError
    case serverError(Int)

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Yanlış URL"
        case .decodingError: return "Data oxunmadı"
        case .serverError(let code): return "Server xətası: \(code)"
        }
    }
}
