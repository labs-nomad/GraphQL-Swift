//
//  GQLAuthorization_Tests.swift
//  GraphQL_Swift_Tests
//
//  Created by Nomad Company on 4/22/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//


//import Quick
//import Nimble
//@testable import GraphQL_Swift
//
////The test class. This class will inherit from QuickSpec.
//class GQLAuthorization_Tests: QuickSpec {
//    
//    /// Override the spec function of the `QuickSpec` superclass
//    override func spec() {
//        //Call super on the spec function
//        super.spec()
//        
//        //Any variables can go here
//        var mockAuth = MockGQLAuthorization()
//        
//        //This will be called once before any of the tests get run
//        beforeSuite {
//            
//        }
//        
//        //This will be called before each new test gets run
//        beforeEach {
//            mockAuth.apiKey = nil
//            mockAuth.clientID = nil
//            mockAuth.jwt = nil
//        }
//        
//        //This is the test Template
//        describe("Mock Authorization Initalization") {
//            context("No Varaibles set", closure: {
//                it("Returns nil for client ID, API Key, JWT, and Headers", closure: {
//                    expect(mockAuth.apiKey).to(beNil())
//                    expect(mockAuth.clientID).to(beNil())
//                    expect(mockAuth.jwt).to(beNil())
//                    expect(mockAuth.authorizationHeader).to(equal(["Authorization": "Bearer "]))
//                })
//            })
//        }
//        
//        describe("Changing Authorization variables") {
//            context("API Key set", closure: {
//                it("Returns nil for everything besides the API Key. Returns a valid auth header with the API Key", closure: {
//                    let apiKey = UUID().uuidString
//                    mockAuth.apiKey = apiKey
//                    expect(mockAuth.clientID).to(beNil())
//                    expect(mockAuth.jwt).to(beNil())
//                    expect(mockAuth.apiKey).to(equal(apiKey))
//                    expect(mockAuth.authorizationHeader).to(equal(["Authorization": "Bearer \(apiKey)"]))
//                })
//            })
//            
//            context("Client ID Set", closure: {
//                it("Returns nil for everythign besides the Client ID. Returns a valid auth header with the Client ID.", closure: {
//                    let clientID = UUID().uuidString
//                    mockAuth.clientID = clientID
//                    expect(mockAuth.clientID).to(equal(clientID))
//                    expect(mockAuth.jwt).to(beNil())
//                    expect(mockAuth.apiKey).to(beNil())
//                    expect(mockAuth.authorizationHeader).to(equal(["Authorization": "Bearer \(clientID)"]))
//                })
//            })
//            
//            
//            context("JWT Set", closure: {
//                it("Returns nil for everythign besides the JWT. Returns a valid auth header with the JWT", closure: {
//                    let jwt = UUID().uuidString
//                    mockAuth.jwt = jwt
//                    expect(mockAuth.jwt).to(equal(jwt))
//                    expect(mockAuth.clientID).to(beNil())
//                    expect(mockAuth.apiKey).to(beNil())
//                    expect(mockAuth.authorizationHeader).to(equal(["Authorization": "Bearer \(jwt)"]))
//                })
//            })
//        }
//        
//    }
//}
