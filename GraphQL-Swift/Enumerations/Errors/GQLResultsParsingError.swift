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
}
