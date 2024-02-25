# JsonKit
A Swift library that makes reading and writing JSON data objects in Swift and converting to the appropriate Swift data objects easy.

[![Swift Package Index](https://img.shields.io/badge/Swift_Package_Index-JsonKit-blue.svg)](https://swiftpackageindex.com/harrisonv789/JsonKit)

---

#### Reading Data

To read a value from a JSON string, use the `get` function:
```swift
let jsonString = "{\"name\": \"John\", \"age\": 30, \"city\": \"New York\"}"

if let age = get(from: jsonString, key: "age", defaultValue: 10) as? Int {
    print("Age: \(age)")
}
```

This function contains an optional `defaultValue` parameter. This parameter will be returned if there is an issue with the JSON data or if the value does not exist.

---

#### Writing Data

To write data in a JSON string, use the `set` function:

```swift
let jsonString = "{\"name\": \"John\", \"age\": 30, \"city\": \"New York\"}"

if let updatedJsonString = set(in: jsonString, forKey: "age", value: 31) {
    print("Updated JSON String: \(updatedJsonString)")
}
```

If there is an error with the JSON data, then a `nil` value will be returned. Otherwise, the new JSON string with the updated data will be returned.