//
//  ProfileData.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import Foundation

struct ProfileData: Codable {
    var profileImage: String
    var firstName: String
    var lastName: String
    var gender: Gender
    var city: String
    var birthDate: Date
}
