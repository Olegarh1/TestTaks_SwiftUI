//
// Data.swift
// TestTask
//
// Created by Oleg Zakladnyi on 22.06.2025

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
