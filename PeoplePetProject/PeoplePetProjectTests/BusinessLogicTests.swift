//
//  BusinessLogicTests.swift
//  PeoplePetProjectTests
//
//  Created by Shefali Mistry on 8/12/17.
//  Copyright © 2017 Shefali Mistry. All rights reserved.
//

import XCTest
import SwaggerClient
@testable import PeoplePetProject

import XCTest
import SwaggerClient
@testable import PeoplePetProject

class BusinessLogicTests: XCTestCase {
    
    func testDataSourceCreatedCorrectlyWithAPIJSON() {

        let jsonString = Mocks.response("people.json")
        let jsonData = jsonString.data(using: String.Encoding.utf8)

        do {
            let people = try JSONDecoder().decode(People.self, from: jsonData!)
            let dataSource = createDatasource(from: people)

            XCTAssert(dataSource["Male"]?.count == 4, "Male should have 4 cats")
            XCTAssert(dataSource["Female"]?.count == 3, "Female should have 3 cats")

        } catch {
            preconditionFailure()
        }

    }
    
}
