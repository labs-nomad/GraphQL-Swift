//
//  GQLResultsParsingError.swift
//  GraphQL-Swift
//
//  Created by Nomad Company on 4/22/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import Foundation


public enum GQLResultsParsingError: Error {
    case noDataKey
    case couldNotMapQueryKey
}
