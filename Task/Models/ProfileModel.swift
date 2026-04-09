//
//  ProfileModel.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import Foundation

struct ProfileResponse: Codable {
    let data: ProfileData
}

struct ProfileData: Codable {
    let profileImage: String
    let firstName: String
    let lastName: String
    let gender: String
    let city: String
    let birthDate: String
}
