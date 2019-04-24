//
//  MockQuery.swift
//  GraphQL_Swift_Tests
//
//  Created by Nomad Company on 4/22/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import GraphQL_Swift


struct MockQuery: GQLRequest {
    
    
    var graphQLLiteral: String = """
    query {
        objects {
            id
        }
    }
    """
    
    var fragments: [GQLFragment]?
    
    var variables: [String : Any]?
    
    
    init() {
        
    }
    
}
