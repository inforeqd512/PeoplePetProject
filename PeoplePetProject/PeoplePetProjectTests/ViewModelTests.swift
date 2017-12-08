//
//  ViewModelTests.swift
//  PeoplePetProjectTests
//
//  Created by Shefali Mistry on 8/12/17.
//  Copyright © 2017 Shefali Mistry. All rights reserved.
//

import XCTest
import SwaggerClient
@testable import PeoplePetProject

class ViewModelTests: XCTestCase {

    let viewModel = ViewModel()

    override func setUp() {
        super.setUp()

        let jsonString = Mocks.response("people.json")
        let jsonData = jsonString.data(using: String.Encoding.utf8)

        do {
            let people = try JSONDecoder().decode(People.self, from: jsonData!)
            let dataSource = createDatasource(from: people)
            viewModel.dataSource = dataSource

        } catch {
            preconditionFailure()
        }
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testNumberOfSections() {
        XCTAssert(viewModel.numberOfSections() == 2, "numberOfSections should be 2")
    }

    func testNumberOfItems() {
        XCTAssert(viewModel.numberOfItems(in: 0) == 4, "numberOfItems in section 0 should be 4")
    }

    func testHeaderImageName() {
        XCTAssert(viewModel.headerImageName(for: 0) == "Male", "headerImageName in section 0 should be Male")
        XCTAssert(viewModel.headerImageName(for: 1) == "Female", "headerImageName in section 1 should be Female")
    }

    func testBezel() {
        XCTAssert(viewModel.bezel(for: .header) == 0, "bezel for header should be 0")
        XCTAssert(viewModel.bezel(for: .cell) == 8, "bezel for cell should be 8")
    }

    func testIdentifier() {
        XCTAssert(viewModel.identifier(for: .header) == "GenderSectionView", "identifier for header should be GenderSectionView")
        XCTAssert(viewModel.identifier(for: .cell) == "PetCell", "identifier for cell should be PetCell")
    }
}
