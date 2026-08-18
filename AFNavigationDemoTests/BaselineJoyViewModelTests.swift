//
//  BaselineJoyViewModelTests.swift
//  AFNavigationDemoTests
//
//  Created by Lisa Fellows on 2026-08-17.
//

import XCTest
@testable import AFNavigationDemo

final class BaselineJoyViewModelTests: XCTestCase {
    private var sut: BaselineJoyViewModel!

    override func setUp() {
        super.setUp()
        sut = BaselineJoyViewModel()
    }

    func test_newAlert_startsNil() {
        XCTAssertNil(sut.newAlert, "newAlert should start nil")
    }

    func test_didTapAdAction_assignsVacationAlert() {
        sut.didTapAdAction()

        XCTAssertEqual(sut.newAlert?.title, "So Sorry!", "didTapAdAction should present the vacation alert")
        XCTAssertEqual(
            sut.newAlert?.message,
            "All of our AI Agents are currently on vacation. Please check back with us once we are back online.",
            "Vacation alert should explain that agents are unavailable"
        )
        XCTAssertEqual(sut.newAlert?.primaryAction.title, "OK", "Vacation alert primary action should be OK")
        XCTAssertNil(sut.newAlert?.secondaryAction, "Vacation alert should not include a secondary action")
    }

    func test_didTapAdAction_assignsNewAlertIdentityEachTime() {
        sut.didTapAdAction()
        let firstAlert = sut.newAlert

        sut.didTapAdAction()
        let secondAlert = sut.newAlert

        XCTAssertNotEqual(firstAlert, secondAlert, "Each tap should assign a new AlertModel so onChange can fire again")
        XCTAssertEqual(secondAlert?.title, "So Sorry!", "Subsequent taps should still present the vacation alert")
    }
}
