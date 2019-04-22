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
    
    public func makeGraphQLRequest<T: GQLRequest>(_ request: T, completion: @escaping(_ data: [String: Any]?, _ error: Error?) -> Void) throws -> URLSessionDataTask {
        
        var urlRequest = try self.definition.asURLRequest()
        
        urlRequest.httpBody = try! request.queryData()
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (p_data, p_response, p_error) in
            if let error = p_error {
                completion(nil, error)
            }else if let response = p_response as? HTTPURLResponse, let data = p_data {
                switch response.statusCode {
                case 200...299:
                    guard let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] else {
                        completion(nil, nil)
                        return
                    }
                    completion(json, nil)
                default:
                    completion(nil, GQLRequestError.invalidStatusCode(code: response.statusCode))
                }
            }else {
                completion(nil, GQLRequestError.couldNotParseResponse)
            }
        }
        
        task.resume()
        
        return task
    }
    
}
