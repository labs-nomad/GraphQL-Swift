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
}
