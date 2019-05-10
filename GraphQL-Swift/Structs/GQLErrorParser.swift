//
//  GQLErrorParser.swift
//  GraphQL-Swift
//
//  Created by Nomad Company on 4/18/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import Foundation


/// Struct that helps make more readable strings from errors
public struct GQLErrorParser {
    
    
    /// Init with nothing.
    public init() {
        
    }
    
    /// Generates an `NSLocalizedString` from the `Error` object.
    ///
    /// - Parameter error: The error you want to get a description out of.
    /// - Returns: The string that makes this as nice an error as possible.
    public func string(forError error: Error) -> String {
        switch error {
        case let e as GQLRequestError:
            return self.string(e)
        case let e as GQLAPIDefinitionError:
            return self.string(e)
        case let e as GQLResultsParsingError:
            return self.string(e)
        case let e as JSONStringEncodingError:
            return self.string(e)
        case let e as NSError:
            return e.localizedDescription
        default:
            return NSLocalizedString("An error occured. We don't have any other information.", comment: "Generic error message")
        }
    }
    
    private func string(_ error: GQLRequestError) -> String {
        switch error {
        case .couldNotConvertToString:
            return NSLocalizedString("Could not convert 'varaibles' to string", comment: "A type cast error in programming.")
        case .couldNotParseResponse:
            return NSLocalizedString("Could not parse HTTP Response or Data", comment: "Could not parse error.")
        case .invalidStatusCode(code: let value):
            return NSLocalizedString("Invlaid response code: \(value)", comment: "Invalid response code from server.")
        }
    }
    
    private func string(_ error: GQLAPIDefinitionError) -> String {
        switch error {
        case .couldNotConstructAuthorization:
            return NSLocalizedString("We could not make the required authorization header", comment: "Something about the request could not be constructed.")
        case .couldNotConstructRequest:
            return NSLocalizedString("We could not construct the request.", comment: "Something about the request could not be constructed.")
        }
    }
    
    private func string(_ error: GQLResultsParsingError) -> String {
        switch error {
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
    
    private func string(_ error: JSONStringEncodingError) -> String {
        switch error {
        case .stringConstructionFromErrorFailed:
            return NSLocalizedString("The JSON could not be converted into a readable format", comment: "Failuer to parse native object into stringified JSON")
        }
    }
}
