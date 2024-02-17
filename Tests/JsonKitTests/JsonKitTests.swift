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

    static var allTests = [
        ("testValidJSON", testValidJSON),
        ("testInvalidJSON", testInvalidJSON),
    ]
}