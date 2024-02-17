// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

func isValid (_ json: String) -> Bool {
    if let jsonData = json.data(using: .utf8) {
        do {
            _ = try JSONSerialization.jsonObject(with: jsonData, options: [])
            return true
        } catch {
            return false
        }
    }
    return false
}