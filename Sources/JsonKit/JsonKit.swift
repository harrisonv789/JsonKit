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

func get(from json: String, key: String, defaultValue: Any? = nil) -> Any? {
    guard let data = json.data(using: .utf8) else {
        return defaultValue // Unable to convert the string to data
    }

    do {
        if let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            return jsonDictionary[key]
        }
    } catch {
        return defaultValue // Error deserializing JSON
    }

    return defaultValue // Default case, should not reach here
}

func get<T>(from json: String, key: String, defaultValue: T? = nil) -> T? {
    guard let data = json.data(using: .utf8) else {
        return defaultValue // Unable to convert the string to data
    }

    do {
        if let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            return jsonDictionary[key] as? T
        }
    } catch {
        return defaultValue // Error deserializing JSON
    }

    return defaultValue // Default case, should not reach here
}