//
//  MockSession.swift
//  GraphQL_Swift_Tests
//
//  Created by Nomad Company on 5/9/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import GraphQL_Swift


public struct MockSession: URLSessionProtocol {
    
    
    let configuration: URLSessionConfiguration
    
    public init(configuration: URLSessionConfiguration) {
        self.configuration = configuration
    }
    
    public func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockTask()
    }
    
    
}

public class MockTask: URLSessionDataTask {

    
    override init() {
        super.init()
    }
}
