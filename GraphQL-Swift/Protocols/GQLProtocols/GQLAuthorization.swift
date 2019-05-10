//
//  GQLAuthorization.swift
//  GraphQL-Swift
//
//  Created by Nomad Company on 4/18/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import Foundation


/// Protocol that defines an authorization for an API
public protocol GQLAuthorization {
    
    /// The client ID if given one
    var clientID: String? { get set }
    
    /// The api key if given one
    var apiKey: String? { get set }
    
    /// The Javascript Web Token if given one.
    var jwt: String? { get set }
    
    /// The computed authorization header.
    var authorizationHeader: [String: String] { get }
}
