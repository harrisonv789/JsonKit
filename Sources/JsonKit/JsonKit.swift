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

func set(in json: String, forKey key: String, value: Any) -> String? {
    guard var jsonDictionary = try? JSONSerialization.jsonObject(with: Data(json.utf8), options: []) as? [String: Any] else {
        return nil // Failed to deserialize the JSON string
    }

    jsonDictionary[key] = value

    do {
        let updatedJsonData = try JSONSerialization.data(withJSONObject: jsonDictionary, options: [])
        guard let updatedJsonString = String(data: updatedJsonData, encoding: .utf8) else {
            return nil // Failed to convert data back to string
        }
        return updatedJsonString
    } catch {
        return nil // Error serializing the updated JSON dictionary
    }
}