//
//  MockAPIDefinition.swift
//  GraphQL_Swift_Tests
//
//  Created by Nomad Company on 4/22/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import GraphQL_Swift


struct MockAPIDefinition: GQLAPIDefinition {
    //MARK: Properties
    var authorization: GQLAuthorization?
    
    var rootRESTURLString: String = "https://mockgraphqlapi.com"
    
    var rootWebsocketURLString: String = "wss://mockgraphqlapi.com"
    
    //MARK: init
    init(authorization: GQLAuthorization? = nil) {
        self.authorization = authorization
    }
}
