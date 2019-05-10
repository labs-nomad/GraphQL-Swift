//
//  JSONStringEncodingError.swift
//  GraphQL-Swift
//
//  Created by Nomad Company on 5/10/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import Foundation


/// An error that can be thrown when an object could not be converted into a JSON String
///
/// - stringConstructionFromErrorFailed: We take an array or dictionary object and convert it into data. We then construct a string from that data with utf8 encoding. If that construction fails then this error is thrown
public enum JSONStringEncodingError: ErrorPrintable {
    case stringConstructionFromErrorFailed
}
