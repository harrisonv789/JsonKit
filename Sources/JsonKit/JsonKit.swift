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