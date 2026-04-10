//
//  Cities.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import Foundation

struct City: Codable {
    let key: String
    let value: String
}

enum CityData {
    static let all: [City] = {
        guard let url = Bundle.main.url(forResource: "cities", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return [] }
        return (try? JSONDecoder().decode([City].self, from: data)) ?? []
    }()
}
