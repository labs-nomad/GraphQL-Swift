//
//  ArrayParsing_Tests.swift
//  GraphQL_Swift_Tests
//
//  Created by Nomad Company on 5/9/19.
//  Copyright © 2019 Nomad Company. All rights reserved.
//

import Quick
import Nimble
@testable import GraphQL_Swift

//The test class. This class will inherit from QuickSpec.
class ArrayParsing_Tests: QuickSpec {
    
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
        describe("Encoding array to Data") {
            context("Empty Int Array into data", closure: {
                it("Produces a data object that has two bytes and can be decoded into an empty array", closure: {
                    let array: [Int] = []
                    let data = try! array.jsonData()
                    expect(data.count).to(equal(2))
                    let decoded = try! JSONSerialization.jsonObject(with: data, options: []) as! [Int]
                    expect(decoded).to(equal(array))
                })
            })
            context("Non empty int array into data", closure: {
                it("Produces a data object with 7 bytes and can be decoded back into the the array", closure: {
                    let array: [Int] = [0, 1, 2]
                    let data = try! array.jsonData()
                    expect(data.count).to(equal(7))
                    let decoded = try! JSONSerialization.jsonObject(with: data, options: []) as! [Int]
                    expect(decoded).to(equal(array))
                })
            })
            context("Empty String array into data", closure: {
                it("Produces a data object that has two bytes and can be decode back into the empty array", closure: {
                    let array: [String] = []
                    let data = try! array.jsonData()
                    expect(data.count).to(equal(2))
                    let decoded = try! JSONSerialization.jsonObject(with: data, options: []) as! [String]
                    expect(decoded).to(equal(array))
                })
            })
            context("Non Empty string array", closure: {
                it("Produces a data object with the correct byte count and can be decoded back into correct array", closure: {
                    let array: [String] = ["hello", "world"]
                    let data = try! array.jsonData()
                    expect(data.count).to(equal(17))
                    let decoded = try! JSONSerialization.jsonObject(with: data, options: []) as! [String]
                    expect(decoded).to(equal(array))
                })
            })
            context("An Array that contains objects", closure: {
                it("Produces a data object with the correct length", closure: {
                    let array: [[String: String]] = [["first":"hello"], ["second":"world"]]
                    let data = try! array.jsonData()
                    expect(data.count).to(equal(38))
                    let decoded = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String: String]]
                    expect(decoded.count).to(equal(2))
                    expect(decoded.first).to(equal(array.first))
                    expect(decoded.last).to(equal(array.last))
                })
            })
        }
        
        describe("Turning array into JSON String") {
            context("", closure: {
                it("", closure: {
                    let array: [Int] = [0,1,2,3]
                    let string = try! array.jsonString()
                    print(string)
                })
            })
        }
        
    }
}
