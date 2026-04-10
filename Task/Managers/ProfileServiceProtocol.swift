//
//  ProfileServiceProtocol.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import Foundation

protocol ProfileServiceProtocol {
    func fetchProfile() async throws -> ProfileData
    func updateProfile(_ data: ProfileData) async throws
}
