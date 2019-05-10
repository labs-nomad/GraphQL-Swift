//
//  DictionaryParsing_Tests.swift
//  GraphQL_Swift_Tests
//
//  Created by Nomad Company on 5/10/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import Quick
import Nimble
@testable import GraphQL_Swift

//The test class. This class will inherit from QuickSpec.
class DictionaryParsing_Tests: QuickSpec {
    
    /// Override the spec function of the `QuickSpec` superclass
    override func spec() {
        //Call super on the spec function
        super.spec()
        
        //Any variables can go here
        
        
        //This will be called once before any of the tests get run
        beforeSuite {
            
        }
        
        //This will be called before each new test gets run
        beforeEach {
            
        }
        
        //This is the test Template
        describe("Encoding Dictionary to data") {
            context("Empty Dictionary into data", closure: {
                it("Produces a data object with the correct length and decodes it correclty", closure: {
                    let dictionary: [String: [Int]] = [:]
                    let data = try! dictionary.jsonData()
                    let decoded = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: [Int]]
                    expect(decoded).to(equal(dictionary))
                })
            })
        }
        
    }
}
