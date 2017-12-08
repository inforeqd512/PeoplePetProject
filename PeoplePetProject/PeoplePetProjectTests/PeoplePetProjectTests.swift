//
//  PeoplePetProjectTests.swift
//  PeoplePetProjectTests
//
//  Created by Shefali Mistry on 8/12/17.
//  Copyright © 2017 Shefali Mistry. All rights reserved.
//

import XCTest
import SwaggerClient
@testable import PeoplePetProject

class PeoplePetProjectTests: XCTestCase {

    func testSuccessfulPetAPIResponseFormat() {
        // This is an example of a functional test case.
        let expectation = self.expectation(description: "API should return in pets within people")
        var apiPeople: [Person]?
        var apiError: Error?
        MockPetAPI.getPets { (people, error) in
            apiPeople = people
            apiError = error
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 1.0) { _ in
            XCTAssert(apiPeople != nil, "success run of api should return people")
            XCTAssert(apiPeople?.count == 6, "person count should be 6")
            XCTAssert(apiPeople?.first?.pets?.count == 2, "bob has 2 pets")
            XCTAssert(apiError == nil, "no api error")
        }
    }

    func testUnSuccessfulPetAPIResponseFormat() {

        let expectation = self.expectation(description: "API should return in pets within people")
        var apiPeople: [Person]?
        var apiError: Error?
        MockPetAPI.getNoPets { (people, error) in
            apiPeople = people
            apiError = error
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 1.0) { _ in
            XCTAssert(apiPeople != nil, "success run of api should return array")
            XCTAssert(apiPeople?.count == 0, "person count should be 0")
            XCTAssert(apiError == nil, "no api error")
        }
    }
    
}
