//
//  GQLNetworkController.swift
//  GraphQL-Swift
//
//  Created by Nomad Company on 4/18/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import Foundation

public class GQLNetworkController: NSObject {
    //MARK: Properties
    /// The definition of the API this networking object was constructed with.
    public let definition: GQLAPIDefinition!
    
    /// The typealiased completion for network requests. `((_ results: GQLNetworkRequestResults) -> Void)`
    public typealias GQLRequestCompletion = ((_ results: GQLNetworkRequestResults) -> Void)
    
    private var session: URLSessionProtocol!
    
    //MARK: Init
    public init(apiDefinition definition: GQLAPIDefinition, session: URLSessionProtocol.Type = URLSession.self) {
        self.definition = definition
        super.init()
        let config = URLSessionConfiguration.ephemeral
        self.session = session.init(configuration: config)
    }
    
    //MARK: Functions
    
    /// Function to make a GQLRequest over the network.
    ///
    /// - Parameters:
    ///   - request: The object that conforms to the `GQLRequest` protocol.
    ///   - returnQueue: This comes back on the `DispatchQueue.main` by default but in case you want something else
    ///   - completion: Optional completion.
    /// - Returns: A `URLSessionDataTask` that can be cancelled if needed.
    /// - Throws: If the request could not be constructed for a myriad of reasons we will throw an error before making the network request. Throw the error into the `GQLErrorParser` for a human readable string.
    public func makeGraphQLRequest<T: GQLRequest>(_ request: T, returnQueue queue: DispatchQueue = DispatchQueue.main, completion: GQLRequestCompletion? = nil) throws -> URLSessionDataTask {
        
        var urlRequest = try self.definition.asURLRequest()
        
        urlRequest.httpBody = try request.queryData()
        
        let task = self.session.dataTask(with: urlRequest) { (p_data, p_response, p_error) in
            if let error = p_error {
                let result = GQLNetworkRequestResults.fail(error)
                queue.async {
                    completion?(result)
                }
            }else if let response = p_response as? HTTPURLResponse, let data = p_data {
                switch response.statusCode {
                case 200...299:
                    do {
                        guard let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] else {
                            let error = GQLResultsParsingError.requestReturnedInvalidJSON
                            let result = GQLNetworkRequestResults.fail(error)
                                queue.async {
                                    completion?(result)
                                }
                            return
                        }
                        let result = GQLNetworkRequestResults.success(json)
                        queue.async {
                            completion?(result)
                        }
                    }catch{
                        let result = GQLNetworkRequestResults.fail(error)
                        queue.async {
                            completion?(result)
                        }
                    }
                default:
                    let error = GQLRequestError.invalidStatusCode(code: response.statusCode)
                    let result = GQLNetworkRequestResults.fail(error)
                    queue.async {
                        completion?(result)
                    }
                }
            }else {
                let error = GQLRequestError.couldNotParseResponse
                let result = GQLNetworkRequestResults.fail(error)
                queue.async {
                    completion?(result)
                }
            }
        }
        
        task.resume()
        
        return task
    }
    
    
}
