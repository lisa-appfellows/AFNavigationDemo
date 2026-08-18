//
//  SubscriptionSignUpViewModelTests.swift
//  AFNavigationDemoTests
//
//  Created by Lisa Fellows on 2026-08-17.
//

import XCTest
@testable import AFNavigationDemo

final class SubscriptionSignUpViewModelTests: XCTestCase {
    private var defaults: UserDefaults!
    private var suiteName: String!
    private var sut: SubscriptionSignUpViewModel!

    override func setUp() {
        super.setUp()
        suiteName = "SubscriptionSignUpViewModelTests.\(UUID().uuidString)"
        defaults = UserDefaults(suiteName: suiteName)
        defaults.removePersistentDomain(forName: suiteName)
        sut = SubscriptionSignUpViewModel(userDefaults: defaults)
    }

    override func tearDown() {
        defaults.removePersistentDomain(forName: suiteName)
        sut = nil
        defaults = nil
        suiteName = nil
        super.tearDown()
    }

    func test_init_defaultsToMonthlyWithNoStoredPlan() {
        XCTAssertEqual(sut.selectedPlan, .monthly, "With no stored plan, selectedPlan should default to monthly")
        XCTAssertEqual(sut.currentPlan, .monthly, "With no stored plan, currentPlan should default to monthly")
        XCTAssertNil(sut.previousPlan, "With no stored plan, previousPlan should be nil")
        XCTAssertNil(sut.newAlert, "newAlert should start nil")
        XCTAssertFalse(sut.dismiss, "dismiss should start false")
        XCTAssertEqual(Array(sut.plans), SubscriptionPlan.allCases, "plans should expose every SubscriptionPlan")
    }

    func test_init_loadsStoredCurrentPlanIntoSelectedPlan() {
        sut.selectedPlan = .annual
        sut.didSubscribe()

        let reloaded = SubscriptionSignUpViewModel(userDefaults: defaults)

        XCTAssertEqual(reloaded.selectedPlan, .annual, "A new view model should load the stored current plan into selectedPlan")
        XCTAssertEqual(reloaded.currentPlan, .annual, "A new view model should load the stored current plan")
        XCTAssertEqual(reloaded.previousPlan, .monthly, "A new view model should load the stored previous plan")
    }

    func test_didSubscribe_savesPlansAndSetsSuccessAlert() {
        sut.selectedPlan = .premium
        sut.didSubscribe()

        XCTAssertEqual(sut.currentPlan, .premium, "didSubscribe should save selectedPlan as currentPlan")
        XCTAssertEqual(sut.previousPlan, .monthly, "didSubscribe should save the prior currentPlan as previousPlan")
        XCTAssertEqual(sut.newAlert?.title, "Subscribed!", "didSubscribe should present the success alert")
        XCTAssertEqual(
            sut.newAlert?.message,
            "Your plan has been updated to Premium.",
            "Success alert should include the selected plan name"
        )
        XCTAssertFalse(sut.dismiss, "didSubscribe should not dismiss the view")
    }

    func test_didRestore_withoutPreviousPlan_setsFailureAlertAndLeavesPlanUnchanged() {
        sut.selectedPlan = .annual
        sut.didRestore()

        XCTAssertEqual(sut.selectedPlan, .annual, "Restore with no previous plan should leave selectedPlan unchanged")
        XCTAssertEqual(sut.currentPlan, .monthly, "Restore with no previous plan should leave currentPlan unchanged")
        XCTAssertNil(sut.previousPlan, "Restore with no previous plan should not create a previous plan")
        XCTAssertEqual(sut.newAlert?.title, "Restoration Failed", "didRestore with no previous plan should present the failure alert")
        XCTAssertEqual(
            sut.newAlert?.message,
            "No previous plan was found. Your plan is still at Annual.",
            "Failure alert should include the currently selected plan name"
        )
    }

    func test_didRestore_withPreviousPlan_restoresSelectionAndSetsSuccessAlert() {
        sut.selectedPlan = .annual
        sut.didSubscribe()
        sut.newAlert = nil

        sut.didRestore()

        XCTAssertEqual(sut.selectedPlan, .monthly, "didRestore should select the previous plan")
        XCTAssertEqual(sut.currentPlan, .monthly, "didRestore should save the restored plan as currentPlan")
        XCTAssertEqual(sut.previousPlan, .annual, "didRestore should save the plan being left as previousPlan")
        XCTAssertEqual(sut.newAlert?.title, "Restored.", "didRestore should present the restore success alert")
        XCTAssertEqual(
            sut.newAlert?.message,
            "Your plan has been restored to Monthly.",
            "Restore success alert should include the restored plan name"
        )
    }

    func test_didTapDismiss_whenPlanUnchanged_togglesDismissWithoutAlert() {
        sut.didTapDismiss()

        XCTAssertTrue(sut.dismiss, "Dismissing with an unchanged plan should toggle dismiss")
        XCTAssertNil(sut.newAlert, "Dismissing with an unchanged plan should not present an alert")
    }

    func test_didTapDismiss_whenPlanChanged_setsWarningAlertWithoutDismissing() {
        sut.selectedPlan = .annual
        sut.didTapDismiss()

        XCTAssertFalse(sut.dismiss, "Dismissing with a changed plan should wait for the warning alert")
        XCTAssertEqual(sut.newAlert?.title, "Warning!", "Dismissing with a changed plan should present the warning alert")
        XCTAssertEqual(sut.newAlert?.primaryAction.title, "Subscribe", "Warning alert primary action should be Subscribe")
        XCTAssertEqual(sut.newAlert?.secondaryAction?.title, "Cancel", "Warning alert secondary action should be Cancel")
        XCTAssertEqual(sut.currentPlan, .monthly, "Warning alert should not subscribe until Subscribe is chosen")
    }

    func test_dismissAlertPrimaryAction_subscribesThenDismisses() {
        sut.selectedPlan = .premium
        sut.didTapDismiss()

        sut.newAlert?.primaryAction.action()

        XCTAssertEqual(sut.currentPlan, .premium, "Warning Subscribe should save selectedPlan as currentPlan")
        XCTAssertEqual(sut.previousPlan, .monthly, "Warning Subscribe should save the prior currentPlan as previousPlan")
        XCTAssertTrue(sut.dismiss, "Warning Subscribe should toggle dismiss")
    }

    func test_dismissAlertSecondaryAction_dismissesWithoutSubscribing() {
        sut.selectedPlan = .premium
        sut.didTapDismiss()

        sut.newAlert?.secondaryAction?.action()

        XCTAssertEqual(sut.currentPlan, .monthly, "Warning Cancel should leave currentPlan unchanged")
        XCTAssertNil(sut.previousPlan, "Warning Cancel should not record a previous plan")
        XCTAssertEqual(sut.selectedPlan, .premium, "Warning Cancel should leave the in-progress selection unchanged")
        XCTAssertTrue(sut.dismiss, "Warning Cancel should toggle dismiss")
    }
}
