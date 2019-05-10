//
//  URLSessionProtocol.swift
//  GraphQL-Swift
//
//  Created by Nomad Company on 5/9/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import Foundation


public protocol URLSessionProtocol {
    init(configuration: URLSessionConfiguration)
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
