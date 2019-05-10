//
//  GQLAPIDefinitionError.swift
//  GraphQL-Swift
//
//  Created by Nomad Company on 4/18/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import Foundation


public enum GQLAPIDefinitionError: ErrorPrintable {
    case couldNotConstructRequest
    case couldNotConstructAuthorization
    
    public func humanReadableString() -> String {
        switch self {
        case .couldNotConstructAuthorization:
            return NSLocalizedString("We could not make the required authorization header", comment: "Something about the request could not be constructed.")
        case .couldNotConstructRequest:
            return NSLocalizedString("We could not construct the request.", comment: "Something about the request could not be constructed.")
        }
    }
}
