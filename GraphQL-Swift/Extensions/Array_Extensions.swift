//
//  Array_Extensions.swift
//  GraphQL-Swift
//
//  Created by Nomad Company on 4/22/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import Foundation


public extension Array {
    /// Function that conveniently turns the array into a JSON encoded Data object.
    ///
    /// - Parameter options: The encoding options if you need them.
    /// - Returns: The array serialized into JSON then converted to data.
    /// - Throws: Will rethrow the the error from the `JSONSerialization` class.
    func jsonData(options: JSONSerialization.WritingOptions = []) throws -> Data {
        let data = try JSONSerialization.data(withJSONObject: self, options: options)
        return data
    }
    /// Returns the array as a JSON String.
    ///
    /// - Returns: The `String` representation of the array as JSON.
    /// - Throws: An error if trying to turn the dictionary to data before turning it into a string.
    func jsonString(options: JSONSerialization.WritingOptions = [], encoding: String.Encoding = String.Encoding.utf8) throws -> String? {
        let data = try self.jsonData(options: options)
        return String(data: data, encoding: encoding)
    }
}
