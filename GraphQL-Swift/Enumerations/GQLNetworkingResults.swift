//
//  GQLNetworkingResults.swift
//  GraphQL-Swift
//
//  Created by Nomad Company on 11/19/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import Foundation


/// The enumeration of things that cam happen when a networking request completes.
public enum GQLNetworkRequestResults {
    case fail(Error)
    case success([String: Any])
}
