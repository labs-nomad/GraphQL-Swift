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
    public let definition: GQLAPIDefinition!
    
    public typealias GQLRequestCompletion = ((_ data: [String: Any]?, _ error: Error?) -> Void)
    
    private var session: URLSession!
    
    let backgroundSessionKey = "GQLNetworkControllerURLSession"
    
    var completions: [Int: GQLRequestCompletion] = [:]
    
    //MARK: Init
    public init(apiDefinition definition: GQLAPIDefinition) {
        self.definition = definition
        super.init()
        let config = URLSessionConfiguration.background(withIdentifier: self.backgroundSessionKey)
        config.isDiscretionary = false
        self.session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }
    
    //MARK: Functions
    
    public func makeGraphQLRequest<T: GQLRequest>(_ request: T, completion: GQLRequestCompletion? = nil) throws -> URLSessionDataTask {
        
        var urlRequest = try self.definition.asURLRequest()
        
        urlRequest.httpBody = try request.queryData()
        
        let task = self.session.dataTask(with: urlRequest)
        
        
        self.completions[task.taskIdentifier] = completion
        
//        let task = self.session.dataTask(with: urlRequest) { (p_data, p_response, p_error) in
//            if let error = p_error {
//                completion?(nil, error)
//            }else if let response = p_response as? HTTPURLResponse, let data = p_data {
//                switch response.statusCode {
//                case 200...299:
//                    guard let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] else {
//                        completion?(nil, nil)
//                        return
//                    }
//                    completion?(json, nil)
//                default:
//                    completion?(nil, GQLRequestError.invalidStatusCode(code: response.statusCode))
//                }
//            }else {
//                completion?(nil, GQLRequestError.couldNotParseResponse)
//            }
//        }
        
        task.resume()
        
        return task
    }
    
}

extension GQLNetworkController: URLSessionDownloadDelegate {
    public func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        
        print("Finished")
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Fininsed download.")
    }
}
