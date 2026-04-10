//
//  NetworkServiceProtocol.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import Foundation

protocol NetworkServiceProtocol {
    func fetchProfile() async throws -> ProfileData
    func updateProfile(firstName: String, lastName: String, gender: String, city: String, birthDate: String) async throws
}
