//
//  URLSessionDataTaskProtocol.swift
//  GraphQL-Swift
//
//  Created by Nomad Company on 5/9/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import Foundation


public protocol URLSessionDataTaskProtocol {
    func cancel()
    
    func suspend()
    
    func resume()
}
