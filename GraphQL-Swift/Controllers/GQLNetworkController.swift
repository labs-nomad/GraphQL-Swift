//
//  GQLNetworkController.swift
//  GraphQL-Swift
//
//  Created by Nomad Company on 4/18/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import Foundation

public struct GraphQLNetworkController {
    //MARK: Properties
    public let definition: GQLAPIDefinition!
    
    //MARK: Init
    public init(apiDefinition definition: GQLAPIDefinition) {
        self.definition = definition
        
        let error = GQLAPIDefinitionError.couldNotConstructRequest
        print(error)
    }
    
    //MARK: Functions
    
    public func makeGraphQLRequest<T: GQLRequest>(_ request: T, completion: @escaping(_ data: [String: Any]) -> Void) throws -> URLSessionDataTask {
        
        var urlRequest = try self.definition.asURLRequest()
        
        urlRequest.httpBody = try! request.queryData()
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (p_data, p_response, p_error) in
            
            guard let data = p_data else {
                completion([:])
                return
            }
            guard let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] else {
                completion([:])
                return
            }
            
            guard let parsedData = json["data"] as? [String: Any] else {
                completion([:])
                return
            }
            
            completion(parsedData)
            
        }
        
        task.resume()
        
        return task
    }
    
}
