//
//  GQLResultsParsingError.swift
//  GraphQL-Swift
//
//  Created by Nomad Company on 4/22/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import Foundation


public enum GQLResultsParsingError: ErrorPrintable {
    case noDataKey
    case couldNotMapQueryKey
    case noReturningKey
    case requestReturnedInvalidJSON
    
    public func humanReadableString() -> String {
        switch self {
        case .couldNotMapQueryKey:
            return NSLocalizedString("We could not parse the results from the API. Specifically, we could not map the query key.", comment: "Error parsing returned results")
        case .noDataKey:
            return NSLocalizedString("We could not parse the results from the API. Specifically, we could not get a result for the 'data' key.", comment: "Error parsing returned results")
        case .noReturningKey:
            return NSLocalizedString("We could not find any 'returning' results from the request", comment: "Unable to parse returning portion of the request.")
        case .requestReturnedInvalidJSON:
            return NSLocalizedString("The data that was returned from the request could not be converted into JSON", comment: "Could not parse JSON")
        }
    }
}
