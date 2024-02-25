// Created by: Harrison Verrios, 2024

import Foundation

/// Retrieves a value from a dictionary based on a given key. If the key is not found or the
/// value cannot be cast to the expected type, the method will return the default value, if
/// provided. Using the '.' character, you can traverse nested dictionaries and it will return
/// the lowest dictionary found, in the appropriate type, or the default value if the key is
/// not found or the value cannot be cast to the expected type.
/// - Parameters:
///     - dictionary: The dictionary to retrieve the value from.
///     - key: The key to search for in the dictionary.
///     - defaultValue: The default value to return if the key is not found or if an error occurs during retrieval.
///     - enableRecursion: A flag to enable or disable recursion when traversing nested dictionaries.
/// - Returns: The value associated with the key, or the default value if the key is not found or if an error occurs.
func get<T> (from dictionary: [String: Any], key: String, defaultValue: T? = nil, enableRecursion: Bool = true) -> T? {
    
    // Check that the dictionary exists
    if dictionary.isEmpty {
        return defaultValue
    }

    // Split the key based on the '.' character and get the first element of the array
    let keys = key.split(separator: ".")
    let firstKey = enableRecursion ? String(keys[0]) : key
    
    // Check if the key exists
    guard let value = dictionary[firstKey] else {
        return defaultValue
    }
    
    // Check if there is no looping keys
    if keys.count == 1 || !enableRecursion {
        return value as? T
    }
    
    // Check if the value is not a dictionary
    guard let innerDict = value as? [String: Any] else {
        return defaultValue
    }
    
    // Create the inner key and return the inner value
    let innerKey = keys[1...].joined(separator: ".")
    return get(from: innerDict, key: innerKey, defaultValue: defaultValue)
}

/// This method will fetch a value from a JSON string and cast it to the expected type.
/// If the key is not found or the value cannot be cast to the expected type, the method
/// will return the default value, if provided. Using the '.' character, you can traverse
/// nested JSON objects and it will return the lowest JSON object found, in the appropriate
/// type, or the default value if the key is not found or the value cannot be cast to the
/// expected type.
/// - Parameters:
///     - json: The JSON string to fetch the value from
///     - key: The key to fetch the value for
///     - defaultValue: The default value to return if the key is not found or the value cannot be cast to the expected type
///     - enableRecursion: A flag to enable or disable recursion when traversing nested dictionaries.
/// - Returns: The value for the given key, or the default value if the key is not found
func get<T> (from json: String, key: String, defaultValue: T? = nil, enableRecursion: Bool = true) -> T? {

    // Convert to a dictionary
    guard let dictionary = fromJson(from: json) else {
        return defaultValue
    }

    // Return the value from the dictionary
    return get(from: dictionary, key: key, defaultValue: defaultValue, enableRecursion: enableRecursion)
}

/// Returns the keys of a given dictionary. This is a unique array
/// of the keys in the dictionary in the order they are added.
/// - Parameters
///     - dictionary: The dictionary to retrieve the keys from.
/// - Returns: An array of keys that are in the dictionary.
func getKeys (from dictionary: [String: Any]) -> [String] {

    // Return the inbuilt method
    return Array(dictionary.keys)
}

/// Returns the keys of a given JSON String. This is a unique array
/// of the keys in the JSON in the order they are added.
/// - Parameters
///     - json: The raw JSON string to retrieve the keys from.
/// - Returns: An array of keys that are in the JSON.
func getKeys (from json: String) -> [String] {

    // Convert to a dictionary
    guard let dictionary = fromJson(from: json) else {
        return []
    }

    // Return the converted dictionary keys
    return getKeys(from: dictionary)
}
