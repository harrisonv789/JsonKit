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

    func testGenericParameterValue() {
        let jsonString = "{\"name\": \"John\", \"age\": 30, \"city\": \"New York\"}"

        // Test fetching and casting to Int
        if let age: Int = get(from: jsonString, key: "age") {
            XCTAssertEqual(age, 30, "Failed to fetch and cast age from JSON (Generic)")
        } else {
            XCTFail("Unable to retrieve or cast age from JSON (Generic)")
        }

        // Test fetching and casting to String
        if let name: String = get(from: jsonString, key: "name") {
            XCTAssertEqual(name, "John", "Failed to fetch and cast name from JSON (Generic)")
        } else {
            XCTFail("Unable to retrieve or cast name from JSON (Generic)")
        }
    }

    func testNonGenericParameterValue() {
        let jsonString = "{\"name\": \"John\", \"age\": 30, \"city\": \"New York\"}"

        // Test fetching and casting to Int
        if let age = get(from: jsonString, key: "age") as? Int {
            XCTAssertEqual(age, 30, "Failed to fetch and cast age from JSON (Non-Generic)")
        } else {
            XCTFail("Unable to retrieve or cast age from JSON (Non-Generic)")
        }

        // Test fetching and casting to String
        if let name = get(from: jsonString, key: "name") as? String {
            XCTAssertEqual(name, "John", "Failed to fetch and cast name from JSON (Non-Generic)")
        } else {
            XCTFail("Unable to retrieve or cast name from JSON (Non-Generic)")
        }
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
        ("testGenericParameterValue", testGenericParameterValue),
        ("testNonGenericParameterValue", testNonGenericParameterValue),
        
    ]
}