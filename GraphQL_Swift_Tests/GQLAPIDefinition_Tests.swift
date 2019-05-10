//
//  GQLAPIDefinition_Tests.swift
//  GraphQL_Swift_Tests
//
//  Created by Nomad Company on 4/22/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//


import Quick
import Nimble
@testable import GraphQL_Swift

//The test class. This class will inherit from QuickSpec.
class GQLAPIDefinition_Tests: QuickSpec {
    
    /// Override the spec function of the `QuickSpec` superclass
    override func spec() {
        //Call super on the spec function
        super.spec()
        
        //Any variables can go here
        var mockAuth: MockGQLAuthorization!
        var mockDefinition: MockAPIDefinition!
        
        //This will be called once before any of the tests get run
        beforeSuite {
            mockAuth = MockGQLAuthorization()
            let jwt = UUID().uuidString
            mockAuth.jwt = jwt
            expect(mockAuth.jwt).to(equal(jwt))
            expect(mockAuth.clientID).to(beNil())
            expect(mockAuth.apiKey).to(beNil())
            expect(mockAuth.authorizationHeader).to(equal(["Authorization": "Bearer \(jwt)"]))
            mockDefinition = MockAPIDefinition(authorization: mockAuth)
        }
        
        //This will be called before each new test gets run
        beforeEach {
            
        }
        
        //This is the test Template
        describe("Definition Initalization") {
            it("Get initalized with all the expected variables", closure: {
                expect(mockDefinition.rootRESTURLString).to(equal("https://mockgraphqlapi.com"))
                expect(mockDefinition.rootWebsocketURLString).to(equal("wss://mockgraphqlapi.com"))
                expect(mockDefinition.authorization).toNot(beNil())
            })
        }
        
    }
}
