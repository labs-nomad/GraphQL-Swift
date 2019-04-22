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
    """
    **/
    var graphQLLiteral: String { get }
    
    /// Some GraphQL statements make use of variables. In fact most of them should. This represents the variables.
    var variables: [String: Any]? { get }
    
    /// Function that returns a dictionary that represents Swift version of the data that needs to be passed to the server to perform a Graph Query.
    ///
    /// - Returns: A Dictionary in the form of `["query": <myQuery>, "variables": <variables>]`.
    /// - Throws: An error if the dictionary could not be constructed.
    func queryDictionary() throws -> [String: Any]
    
    /// The Dictionary that represents the varaibles in a GraphQL Request needs to be converted into a JSON strign. This function accomplishes that.
    ///
    /// - Returns: The JSON Encoded string or nil if the `varaibles` property is nil.
    /// - Throws: An error if the dictionary could not be seralized correctly.
    func variablesString() throws -> String?
    
    /// The Swift dictionary in the form of `["query": <myQuery>, "variables": <variables>]` encoded as data that is ready to be sent in the POST body of the graph QL Request.
    ///
    /// - Returns: The dictionary encoded as `Data`
    /// - Throws: An error if the encoding went wrong.
    func queryData() throws -> Data
    
//    /// A network request returns JSON with the results from the request. It's the requests responsability to decode it into it's associated type. Do that is this function.
//    ///
//    /// - Parameter data: The results of the request
//    /// - Returns: An Array of the associated type
//    /// - Throws: An error if we could not get the associated type from the JSON.
//    func parseResults(_ data: [String: Any]) throws -> [Result]
//
//    /// This associated type should map to the type or types that this request is trying to perform GraphQL on.
//    associatedtype Result
}


public extension GQLRequest {
    func queryDictionary() throws -> [String: Any] {
        if let variablesString = try self.variablesString() {
            return ["query": "\(self.graphQLLiteral)", "variables": variablesString]
        }else {
            return ["query": "\(self.graphQLLiteral)"]
        }
    }
    
    
    func variablesString() throws -> String? {
        guard let unwrappedVaraibles = self.variables else {
            return nil
        }
        let variablesData = try JSONSerialization.data(withJSONObject: unwrappedVaraibles, options: .prettyPrinted)
        
        guard let variablesString = String(data: variablesData, encoding: .utf8) else {
            throw GQLRequestError.couldNotConvertToString
        }
        
        return variablesString
    }
    
    func queryData() throws -> Data {
        let queryDictionary = try self.queryDictionary()
        return try JSONSerialization.data(withJSONObject: queryDictionary, options: .prettyPrinted)
    }
}
