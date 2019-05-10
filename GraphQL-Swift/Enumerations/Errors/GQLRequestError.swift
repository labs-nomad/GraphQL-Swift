//
//  GQLRequestError.swift
//  GraphQL-Swift
//
//  Created by Nomad Company on 4/18/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import Foundation


public enum GQLRequestError: ErrorPrintable {

    
    case couldNotConvertToString
    case invalidStatusCode(code: Int)
    case couldNotParseResponse
    
    public func humanReadableString() -> String {
        switch self {
        case .couldNotConvertToString:
            return NSLocalizedString("Could not convert 'varaibles' to string", comment: "A type cast error in programming.")
        case .couldNotParseResponse:
            return NSLocalizedString("Could not parse HTTP Response or Data", comment: "Could not parse error.")
        case .invalidStatusCode(code: let value):
            return NSLocalizedString("Invlaid response code: \(value)", comment: "Invalid response code from server.")
        }
    }
}
