// Created by: Harrison Verrios, 2024

import XCTest
@testable import JsonKit

final class JsonKitTests: XCTestCase {
    
    let DEFAULT_JSON: String = "{\"name\": \"John\", \"age\": 30, \"address\": {\"city\": \"New York\"}}"
    
    func testIsValid() {
        XCTAssertTrue(isValid(DEFAULT_JSON), "Expected a valid JSON string")
        
        let invalidJSONString = "This is not a valid JSON string"
        XCTAssertFalse(isValid(invalidJSONString), "Expected an invalid JSON string")
    }
    
    func testGet() {
        // Test fetching an existing key
        if let name: String = get(from: DEFAULT_JSON, key: "name") {
            XCTAssertEqual(name, "John", "Failed to fetch value for existing key")
        } else {
            XCTFail("Unable to retrieve value for existing key")
        }

        // Test fetching a non-existing key
        let nonExistingKey: String? = get(from: DEFAULT_JSON, key: "salary")
        XCTAssertNil(nonExistingKey, "Expected nil value for non-existing key")

        // Test fetching a nested key
        if let city: String = get(from: DEFAULT_JSON, key: "address.city") {
            XCTAssertEqual(city, "New York", "Failed to fetch value for nested key")
        } else {
            XCTFail("Unable to retrieve value for nested key")
        }

        // Test fetching a nested key with non-existing intermediate key
        let nonExistingNestedKey: String? = get(from: DEFAULT_JSON, key: "address.street")
        XCTAssertNil(nonExistingNestedKey, "Expected nil value for non-existing nested key")

        // Test fetching a key with default value
        let defaultValue: Int = 0
        let age: Int = get(from: DEFAULT_JSON, key: "age", defaultValue: defaultValue)!
        XCTAssertEqual(age, 30, "Failed to fetch value for key with default value")

        // Test fetching a non-existing key with default value
        let nonExistingKeyWithDefaultValue: String = "Default"
        let nonExistingValue: String = get(from: DEFAULT_JSON, key: "salary", defaultValue: nonExistingKeyWithDefaultValue)!
        XCTAssertEqual(nonExistingValue, nonExistingKeyWithDefaultValue, "Failed to fetch default value for non-existing key")
    }

    func testSet() {

        // Test setting a new value for the "age" key
        var updatedJsonString: String = set(in: DEFAULT_JSON, key: "age", value: 31)
        var expectedInt: Int? = get(from: updatedJsonString, key: "age")
        XCTAssertEqual(31, expectedInt, "Failed to set a new value for the \"age\" key.")

        // Test setting a new value for a non-existing key
        updatedJsonString = set(in: DEFAULT_JSON, key: "salary", value: 50000)
        expectedInt = get(from: updatedJsonString, key: "salary")
        XCTAssertEqual(50000, expectedInt, "Failed to set a new value for a non-existing key.")
        
        // Test setting a recursive vvalue
        updatedJsonString = set(in: DEFAULT_JSON, key: "address.city", value: "Sydney")
        let expectedString: String? = get(from: updatedJsonString, key: "address.city")
        XCTAssertEqual("Sydney", expectedString, "Failed to set a string value for the \"address.city\" key.")
    }

    static var allTests = [
        ("testIsValid", testIsValid),
        ("testGet", testGet),
        ("testSetJSONValue", testSet)
    ]
}
