//
//  GQLRequest.swift
//  GraphQL-Swift
//
//  Created by Nomad Company on 4/18/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import Foundation


/// Protocol that defines what a native GraphQL request needs.
public protocol GQLRequest {
    /**
    This is the GraphQL string that is the literal GraphQL that you want to send. Recommended to to a milti-line strign literal like this:
    """
     query {
        users {
            id
            name
        }
     }
     
    If you are using fragments you will have to include your fragment names in this literal. This library does not have real time checking or insertion of fragments. Yet.
    """
    **/
    var graphQLLiteral: String { get }
    
    /// Some GraphQL statements make use of variables. In fact most of them should. This represents the variables.
    var variables: [String: Any]? { get }
    
    /// Any Fragment that needs to be part of this request.
    var fragments: [GQLFragment]? { get }
    
    /// Function that returns a dictionary that represents Swift version of the data that needs to be passed to the server to perform a Graph Query.
    ///
    /// - Returns: A Dictionary in the form of `["query": <myQuery>, "variables": <variables>]`.
    /// - Throws: An error if the dictionary could not be constructed.
    func queryDictionary() throws -> [String: Any]
    
    /// The Swift dictionary in the form of `["query": <myQuery>, "variables": <variables>]` encoded as data that is ready to be sent in the POST body of the graph QL Request.
    ///
    /// - Returns: The dictionary encoded as `Data`
    /// - Throws: An error if the encoding went wrong.
    func queryData() throws -> Data

}


public extension GQLRequest {
    func queryDictionary() throws -> [String: Any] {
        var literal = self.graphQLLiteral
        
        for item in self.fragments ?? [] {
            literal += " \(item.fragmentLiteral)"
        }
        
        guard let variables = self.variables else {
            return ["query": "\(literal)"]
        }
        
        return ["query": "\(literal)", "variables": variables]
    }
    
    func queryData() throws -> Data {
        let queryDictionary = try self.queryDictionary()
        return try JSONSerialization.data(withJSONObject: queryDictionary, options: .prettyPrinted)
    }
}
