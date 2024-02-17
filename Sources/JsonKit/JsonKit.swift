// Created by: Harrison Verrios, 2024

import Foundation

/// Check if a given string is a valid JSON
/// - Parameter json: The JSON string to be validated
/// - Returns: A boolean value indicating whether the given string is a valid JSON
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

/// Fetch a value from a JSON string
/// - Parameters:
///     - json: The JSON string to fetch the value from
///     - key: The key to fetch the value for
///     - defaultValue: The default value to return if the key is not found or the value cannot be cast to the expected type
/// - Returns: The value for the given key, or the default value if the key is not found or the value cannot be cast to the expected type
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

// Document the function below
/// Fetch a value from a JSON string
/// - Parameters:
///     - json: The JSON string to fetch the value from
///     - key: The key to fetch the value for
///     - defaultValue: The default value to return if the key is not found or the value cannot be cast to the expected type
/// - Returns: The value for the given key, or the default value if the key is not found or the value cannot be cast to the expected type
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

/// Set a value in a JSON string
/// - Parameters:
///     - json: The JSON string to set the value in
///     - key: The key to set the value for
///     - value: The value to set for the given key
/// - Returns: The updated JSON string with the new value set for the given key
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