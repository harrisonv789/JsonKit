// Created by: Harrison Verrios, 2024

import XCTest
@testable import JsonKit

final class JsonKitTests: XCTestCase {
    
    func testValidJSON() {
        let validJSONString = "{\"name\": \"John\", \"age\": 30}"
        XCTAssertTrue(isValid(validJSONString), "Expected a valid JSON string")
    }

    func testInvalidJSON() {
        let invalidJSONString = "This is not a valid JSON string"
        XCTAssertFalse(isValid(invalidJSONString), "Expected an invalid JSON string")
    }

    func testGetFromJSON() {
        let jsonString = "{\"name\": \"John\", \"age\": 30, \"address\": {\"city\": \"New York\"}}"

        // Test fetching an existing key
        if let name: String = get(from: jsonString, key: "name") {
            XCTAssertEqual(name, "John", "Failed to fetch value for existing key")
        } else {
            XCTFail("Unable to retrieve value for existing key")
        }

        // Test fetching a non-existing key
        let nonExistingKey: String? = get(from: jsonString, key: "salary")
        XCTAssertNil(nonExistingKey, "Expected nil value for non-existing key")

        // Test fetching a nested key
        if let city: String = get(from: jsonString, key: "address.city") {
            XCTAssertEqual(city, "New York", "Failed to fetch value for nested key")
        } else {
            XCTFail("Unable to retrieve value for nested key")
        }

        // Test fetching a nested key with non-existing intermediate key
        let nonExistingNestedKey: String? = get(from: jsonString, key: "address.street")
        XCTAssertNil(nonExistingNestedKey, "Expected nil value for non-existing nested key")

        // Test fetching a key with default value
        let defaultValue: Int = 0
        let age: Int = get(from: jsonString, key: "age", defaultValue: defaultValue)!
        XCTAssertEqual(age, 30, "Failed to fetch value for key with default value")

        // Test fetching a non-existing key with default value
        let nonExistingKeyWithDefaultValue: String = "Default"
        let nonExistingValue: String = get(from: jsonString, key: "salary", defaultValue: nonExistingKeyWithDefaultValue)!
        XCTAssertEqual(nonExistingValue, nonExistingKeyWithDefaultValue, "Failed to fetch default value for non-existing key")
    }

    func testSetJSONValue() {
        let jsonString = "{\"name\": \"John\", \"age\": 30, \"city\": \"New York\"}"

        // Test setting a new value for the "age" key
        if let updatedJsonString = set(in: jsonString, forKey: "age", value: 31) {
            let expectedUpdatedJsonString = "{\"name\": \"John\", \"age\": 31, \"city\": \"New York\"}"
            XCTAssertEqual(updatedJsonString, expectedUpdatedJsonString, "Failed to set a new value for the \"age\" key.")
        } else {
            XCTFail("Failed to update JSON string.")
        }

        // Test setting a new value for a non-existing key
        if let updatedJsonString = set(in: jsonString, forKey: "salary", value: 50000) {
            let expectedUpdatedJsonString = "{\"name\": \"John\", \"age\": 30, \"city\": \"New York\", \"salary\": 50000}"
            XCTAssertEqual(updatedJsonString, expectedUpdatedJsonString, "Failed to set a new value for a non-existing key.")
        } else {
            XCTFail("Failed to update JSON string.")
        }
    }

    static var allTests = [
        ("testValidJSON", testValidJSON),
        ("testInvalidJSON", testInvalidJSON),
        ("testGetFromJSON", testGetFromJSON),
        ("testSetJSONValue", testSetJSONValue)
    ]
}
