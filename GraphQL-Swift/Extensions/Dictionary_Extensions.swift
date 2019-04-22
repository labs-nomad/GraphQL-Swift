//
//  Dictionary_Extensions.swift
//  GraphQL-Swift
//
//  Created by Nomad Company on 4/22/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import Foundation


public extension Dictionary where Key == String {
    func parseDataKey() throws -> [String: Any] {
        let dataKey = "data"
        guard let data = self[dataKey] as? [String: Any] else {
            throw GQLResultsParsingError.noDataKey
        }
        return data
    }
    
    func parseDictionaryResults(queryKey key: String) throws -> [String: Any] {
        let data = try self.parseDataKey()
        guard let results = data[key] as? [String: Any] else {
            throw GQLResultsParsingError.couldNotMapQueryKey
        }
        return results
    }
    
    func parseArrayResults(queryKey key: String) throws -> [[String: Any]] {
        let data = try self.parseDataKey()
        guard let results = data[key] as? [[String: Any]] else {
            throw GQLResultsParsingError.couldNotMapQueryKey
        }
        return results
    }
    
}
