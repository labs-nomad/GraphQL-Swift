//
//  ErrorPrintable.swift
//  GraphQL-Swift
//
//  Created by Nomad Company on 5/10/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import Foundation


/// Protocol that adds a humad readable function to an `Error` protocol type.
public protocol ErrorPrintable: Error {
    /// Function that will return a human readable string for the Error
    ///
    /// - Returns: A string that could either be printed out to the console or shown to the user.
    func humanReadableString() -> String
}


