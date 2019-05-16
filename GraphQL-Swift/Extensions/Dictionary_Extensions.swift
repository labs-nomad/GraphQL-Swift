//
//  Dictionary_Extensions.swift
//  GraphQL-Swift
//
//  Created by Nomad Company on 4/22/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import Foundation


public extension Dictionary where Key == String {
    /// Function that conveniently turns the dictionary into a JSON encoded Data object.
    ///
    /// - Parameter options: The encoding options if you need them.
    /// - Returns: The dictionary serialized into JSON then converted to data.
    /// - Throws: Will rethrow the the error from the `JSONSerialization` class.
    func jsonData(options: JSONSerialization.WritingOptions = []) throws -> Data {
        let data = try JSONSerialization.data(withJSONObject: self, options:options)
        return data
    }
    
    /// Returns the Dictionary as a JSON String.
    ///
    /// - Returns: The `String` representation of the Dictionary as JSON.
    /// - Throws: An error if trying to turn the dictionary to data before turning it into a string.
    func jsonString(options: JSONSerialization.WritingOptions = [], encoding: String.Encoding = String.Encoding.utf8) throws -> String? {
        let data = try self.jsonData(options: options)
        return String(data: data, encoding: encoding)
    }
    
    
    /// All GraphQL request return as a JSON dictionary with 'data' as the key. The data key always returns a dictionary with keys belonging to the top level fields in the query.
    ///
    /// - Returns: The dictionary of fields and their values that were in the data.
    /// - Throws: If we could not find a 'data' key in the dictionary a `GQLResultsParsingError.noDataKey` is thrown.
    func parseDataKey() throws -> [String: Any] {
        let dataKey = "data"
        guard let data = self[dataKey] as? [String: Any] else {
            throw GQLResultsParsingError.noDataKey
        }
        return data
    }
    
    /// Function to assist in parsing out the 'returning' data from a GraphQL mutation.
    ///
    /// - Parameter key: If you wish to parse the field first you can provide it and the function will try to parse the dictionary out that field first. Otherwise it tires to parse the 'returning' key first
    /// - Returns: An Array of dictionaries.
    /// - Throws: A `GQLResultsParsingError` error.
    func parseReturningKey(fieldKey key: String? = nil) throws -> [[String: Any]] {
        let dictiory: [String: Any]
        if let unwrappedKey = key {
            dictiory = try self.parseDictionaryResults(fieldKey: unwrappedKey)
        }else {
            dictiory = self
        }
        guard let returning = dictiory["returning"] as? [[String: Any]] else {
            throw GQLResultsParsingError.noReturningKey
        }
        return returning
    }
    
    /// Any top level field in a GraphQL query will contain either a dictionary or array. This is a helper function to parse a top level field that is a dictionary.
    ///
    /// - Parameter key: The field you are trying to parse.
    /// - Returns: A dictionary with the data
    /// - Throws: An `GQLResultsParsingError.couldNotMapQueryKey` if the function failed to parse the provided key.
    func parseDictionaryResults(fieldKey key: String) throws -> [String: Any] {
        let data = try self.parseDataKey()
        guard let results = data[key] as? [String: Any] else {
            throw GQLResultsParsingError.couldNotMapQueryKey
        }
        return results
    }
    
    /// Any top level field in a GraphQL query will contain either a dictionary or array. This is a helper function to parse a top level field that is an array.
    ///
    /// - Parameter key: The field you are trying to parse.
    /// - Returns: A array with the data
    /// - Throws: An `GQLResultsParsingError.couldNotMapQueryKey` if the function failed to parse the provided key.
    func parseArrayResults(fieldKey key: String) throws -> [[String: Any]] {
        let data = try self.parseDataKey()
        guard let results = data[key] as? [[String: Any]] else {
            throw GQLResultsParsingError.couldNotMapQueryKey
        }
        return results
    }
    
}
