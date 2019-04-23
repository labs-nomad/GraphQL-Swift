//
//  Array_Extensions.swift
//  GraphQL-Swift
//
//  Created by Nomad Company on 4/22/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import Foundation


public extension Array {
    func jsonData() throws -> Data {
        let data = try JSONSerialization.data(withJSONObject: self, options: [])
        return data
    }
    
    func jsonString() throws -> String? {
        let data = try self.jsonData()
        return String(data: data, encoding: String.Encoding.utf8)
    }
}
