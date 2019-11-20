//
//  UserQuery.swift
//  GraphQL_Swift_Tests
//
//  Created by Nomad Company on 11/19/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import GraphQL_Swift

let mockAuth = MockGQLAuthorization()

let mockAPI =  MockAPIDefinition(authorization: mockAuth)

let networkController = GQLNetworkController(apiDefinition: mockAPI)

struct UserQuery: GQLQuery {

    var graphQLLiteral: String = """
    query {
        user {
            id
            email
            name
        }
    }
    """
    
    var fragments: [GQLFragment]?
    
    var variables: [String : Any]?
    
    init() {
        
    }
    
}

let userQuery = UserQuery()

func run() {
do {
    let dataTask = try networkController.makeGraphQLRequest(userQuery, completion: { (results) in
        switch results {
        case .fail(let error):
            print("Error: \(error)")
            break
        case .success(let dictionary):
            do {
                //If your selection set is a dictionary
                let users = try dictionary.parseDictionaryResults(fieldKey: "user")
                print(users)
                //If your selection set is an array
                let users = try dictionary.parseArrayResults(fieldKey: "user")
                print(users)
            }catch{
                //Any parsing errors
            }
        }
    })
}catch{
    //Any errors that were thrown before the request was made.
}
}
