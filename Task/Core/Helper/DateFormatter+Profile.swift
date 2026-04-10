//
//  DateFormatter+Profile.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import Foundation

extension DateFormatter {
    static let profileDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
