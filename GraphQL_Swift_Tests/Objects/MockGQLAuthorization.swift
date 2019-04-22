//
//  MockGQLAuthorization.swift
//  GraphQL_Swift_Tests
//
//  Created by Nomad Company on 4/22/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import GraphQL_Swift


struct MockGQLAuthorization: GQLAuthorization {
    //MARK: Properties
    var clientID: String?
    
    var apiKey: String?
    
    var jwt: String?
    
    var authorizationHeader: [String : String] {
        return ["Authorization": "Bearer \(self.jwt ?? self.apiKey ?? self.clientID ?? "")"]
    }
    
    //MARK: init
    init() {
        
    }
}
