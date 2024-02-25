// Created by: Harrison Verrios, 2024

import Foundation

/// Set a value in a dictionary based on a given key. If the key is not found,
/// the method will return the original dictionary. Using the '.' character, you can
/// traverse nested dictionaries and it will return the updated dictionary with the
/// value set.
/// - Parameters:
///     - dictionary: The dictionary to set the value in. 
///     - key: The key to set the value for.
///     - value: The value to set for the given key.
///     - enableRecursion: A flag to enable or disable recursion when traversing nested dictionaries.
/// - Returns: The updated dictionary with the new value set for the given key.
func set<T> (in dictionary: [String: Any], key: String, value: T? = nil, enableRecursion: Bool = true) -> [String: Any] {
    
    // Check that the dictionary exists and is not empty
    if dictionary.isEmpty {
        return dictionary
    }

    // Split the key based on the '.' character and get the first element of the array
    let keys = key.split(separator: ".")
    let firstKey = enableRecursion ? String(keys[0]) : key
    
    // Check if there is no looping keys
    if keys.count == 1 || !enableRecursion {
        var newDictionary = dictionary
        newDictionary[firstKey] = value
        return newDictionary
    }
    
    // Check if the key exists
    guard let dictionaryValue = dictionary[firstKey] else {
        return dictionary
    }
    
    // Check if the value is not a dictionary
    guard var innerDict = dictionaryValue as? [String: Any] else {
        return dictionary
    }
    
    // Create the inner key and return the inner value
    let innerKey = keys[1...].joined(separator: ".")
    innerDict = set(in: innerDict, key: innerKey, value: value, enableRecursion: enableRecursion)
    var newDictionary = dictionary
    newDictionary[firstKey] = innerDict
    return newDictionary
}

/// Set a value in a JSON string based on a given key. If the key is not found,
/// the method will return the JSON string. Using the '.' character, you can
/// traverse nested JSON objects and it will return the updated JSON string with the
/// value set.
/// - Parameters:
///     - json: The JSON string to set the value in. 
///     - key: The key to set the value for.
///     - value: The value to set for the given key.
///     - enableRecursion: A flag to enable or disable recursion when traversing nested dictionaries.
/// - Returns: The updated JSON with the new value set for the given key.
func set<T> (in json: String, key: String, value: T? = nil, enableRecursion: Bool = true) -> String {

    // Convert to a dictionary
    guard let dictionary = fromJson(from: json) else {
        return json
    }

    // Delete the value from the dictionary
    let updatedDictionary = set(in: dictionary, key: key, value: value, enableRecursion: enableRecursion)

    // Convert the updated dictionary to a JSON string
    guard let updatedJson = toJson(from: updatedDictionary) else {
        return json
    }
    return updatedJson
}
