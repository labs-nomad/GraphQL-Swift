//
//  GQLAPIDefinition.swift
//  GraphQL-Swift
//
//  Created by Nomad Company on 4/18/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import Foundation

public protocol GQLAPIDefinition {
    /// The authorization for this API
    var authorization: GQLAuthorization? { get }
    /// The root URL for REST requests
    var rootRESTURLString: String { get }
    /// The root URL for websocket requests.
    var rootWebsocketURLString: String { get }
    /// Function that returns a configured `URLRequest` for a `URLSession`
    ///
    /// - Returns: The `URLRequest` configured to `POST` and with an authorization header added if it found one. If you don't like this behavior you can always override.
    /// - Throws: Throws a `GQLAPIDefinitionError`
    func asURLRequest() throws -> URLRequest
}

public extension GQLAPIDefinition {
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: self.rootRESTURLString) else {
            throw GQLAPIDefinitionError.couldNotConstructRequest
        }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        guard let authHeader = self.authorization?.authorizationHeader else {
            return request
        }
        
        for key in authHeader.keys {
            if let value: String = authHeader[key] {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}
