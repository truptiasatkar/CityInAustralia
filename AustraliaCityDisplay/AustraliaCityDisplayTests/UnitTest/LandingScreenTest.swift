//
//  LandingScreenTest.swift
//  AustraliaCityDisplayTests
//
//  Created by trupti.asatkar on 18/03/25.
//

import XCTest
import SwiftUI
@testable import AustraliaCityDisplay

class LandingScreenTest: XCTestCase {

    // Test for ensuring data is loaded properly in the view model
    func testViewModelDataLoading() {
        let viewModel = ListViewModel()
        let expectation = self.expectation(description: "Load data")
        
        viewModel.loadData() // Assuming this function loads data asynchronously
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertFalse(viewModel.groupedCities.isEmpty, "Grouped cities should not be empty after data is loaded.")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }

    // Test for checking section expansion behavior
    func testToggleSection() {
        let listView = ListView()

        // Initial state: no expanded section
        XCTAssertNil(listView.currentExpandedState)

        // Toggle section
        listView.toggleSection(state: "New South Wales")
        XCTAssertEqual(listView.currentExpandedState, "New South Wales")

        // Toggle again to collapse
        listView.toggleSection(state: "New South Wales")
        XCTAssertNil(listView.currentExpandedState)
    }
}
