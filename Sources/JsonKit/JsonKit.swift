// Created by: Harrison Verrios, 2024

import Foundation

/// Check if a given string is a valid JSON and returns the flag. This
/// will also determine if it can be deserialized into a standard dictionary.
/// - Parameters
///     - json: The JSON string to be validated
/// - Returns: A boolean value indicating whether the given string is a valid JSON
func isValid (_ json: String) -> Bool {
    
    // Convert the data to a dictionary and return whether the value is nil
    return fromJson(from: json) != nil
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
