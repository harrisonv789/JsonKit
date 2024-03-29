// Created by: Harrison Verrios, 2024

import Foundation

/// Converts a JSON String to a dictionary of type [String: Any].
/// If the JSON string is invalid, the method will return nil.
/// - Parameters:
///     - json: The JSON string to be converted.
/// - Returns: The dictionary representation of the JSON string, or nil if the JSON string is invalid.
func fromJson (from json: String) -> [String : Any]? {
    
    // Check that the data exists and can be converted to a string
    guard let data = json.data(using: .utf8) else {
        return nil
    }
    
    do {
        // Try to deserialize the JSON string to a valid dictionary
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return nil
        }
        return dictionary
    }
    
    // Catch any conversion issues
    catch {
        return nil
    }
}

/// Converts a dictionary of type [String: Any] to a JSON string.
/// If the dictionary is invalid, the method will return nil.
/// - Parameters:
///     - dictionary: The dictionary to be converted.
/// - Returns: The JSON string representation of the dictionary, or nil if the dictionary is invalid.
func toJson (from dictionary: [String: Any]) -> String? {
    
    do {
        // Try to serialize the dictionary to a valid JSON string
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
        guard let json = String(data: data, encoding: .utf8) else {
            return nil
        }
        return json
    }
    
    // Catch any conversion issues
    catch {
        return nil
    }
}