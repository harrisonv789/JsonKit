// Created by: Harrison Verrios, 2024

import Foundation

/// Deletes a value from a dictionary based on a given key. If the key is not found, 
/// the method will return the original dictionary. Using the '.' character, you can 
/// traverse nested dictionaries and it will return the updated dictionary with the 
/// value removed.
/// - Parameters:
///     - dictionary: The dictionary to delete the value from.
///     - key: The key to delete from the dictionary.
///     - enableRecursion: A flag to enable or disable recursion when traversing nested dictionaries.
/// - Returns: The updated dictionary with the value removed.
func delete (in dictionary: [String: Any], key: String, enableRecursion: Bool = true) -> [String: Any] {
        
    // Check that the dictionary exists and is not empty
    if dictionary.isEmpty {
        return dictionary
    }

    // Split the key based on the '.' character and get the first element of the array
    let keys = key.split(separator: ".")
    let firstKey = enableRecursion ? String(keys[0]) : key
    
    // Check if the key exists
    guard let value = dictionary[firstKey] else {
        return dictionary
    }
    
    // Check if there is no looping keys
    if keys.count == 1 || !enableRecursion {
        var newDictionary = dictionary
        newDictionary.removeValue(forKey: firstKey)
        return newDictionary
    }
    
    // Check if the value is not a dictionary
    guard var innerDict = value as? [String: Any] else {
        return dictionary
    }
    
    // Create the inner key and return the inner value
    let innerKey = keys[1...].joined(separator: ".")
    innerDict = delete(in: innerDict, key: innerKey, enableRecursion: enableRecursion)
    var newDictionary = dictionary
    newDictionary[firstKey] = innerDict
    return newDictionary
}

/// This method will delete a value from a JSON string. Using the '.' character, you can
/// traverse nested JSON objects and it will return the updated JSON string with the value
/// removed.
/// - Parameters:
///     - json: The JSON string to delete the value from.
///     - key: The key to delete from the JSON string.
///     - enableRecursion: A flag to enable or disable recursion when traversing nested dictionaries.
/// - Returns: The updated JSON string with the value removed.
func delete (in json: String, key: String, enableRecursion: Bool = true) -> String? {

    // Convert to a dictionary
    guard let dictionary = fromJson(from: json) else {
        return nil
    }

    // Delete the value from the dictionary
    let updatedDictionary = delete(in: dictionary, key: key, enableRecursion: enableRecursion)

    // Convert the updated dictionary to a JSON string
    guard let updatedJson = toJson(from: updatedDictionary) else {
        return nil
    }
    return updatedJson
}