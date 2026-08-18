//
//  SubscriptionSignUpViewModel.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import AFNavigationKit
import SwiftUI

@Observable
final class SubscriptionSignUpViewModel {
    let userDefaults: UserDefaults
    let plans = SubscriptionPlan.allCases

    var selectedPlan = SubscriptionPlan.monthly
    var newAlert: AlertModel?
    var dismiss: Bool = false

    private let currentPlanKey = "subscription_current_plan"
    @ObservationIgnored var currentPlan: SubscriptionPlan {
        get {
            let stored = userDefaults.string(forKey: currentPlanKey) ?? ""
            return .init(rawValue: stored) ?? .monthly
        }
        set {
            userDefaults.set(newValue.rawValue, forKey: currentPlanKey)
        }
    }

    private let previousPlanKey = "subscription_previous_plan"
    @ObservationIgnored var previousPlan: SubscriptionPlan? {
        get {
            let stored = userDefaults.string(forKey: previousPlanKey) ?? ""
            return .init(rawValue: stored)
        }
        set {
            if let newValue = newValue {
                userDefaults.set(newValue.rawValue, forKey: previousPlanKey)
            }
        }
    }

    private var successAlert: AlertModel {
        let primary = AlertAction(title: "OK", role: .cancel) {}
        return AlertModel(
            title: "Subscribed!",
            message: "Your plan has been updated to \(selectedPlan.name).",
            primaryAction: primary
        )
    }

    private var restoreSuccessAlert: AlertModel {
        let primary = AlertAction(title: "OK", role: .cancel) {}
        return AlertModel(
            title: "Restored.",
            message: "Your plan has been restored to \(selectedPlan.name).",
            primaryAction: primary
        )
    }

    private var restoreFailureAlert: AlertModel {
        let primary = AlertAction(title: "OK", role: .cancel) {}
        return AlertModel(
            title: "Restoration Failed",
            message: "No previous plan was found. Your plan is still at \(selectedPlan.name).",
            primaryAction: primary
        )
    }

    private var dismissAlert: AlertModel {
        let primary = AlertAction(title: "Subscribe", role: .none) { [weak self] in
            guard let self else { return }
            previousPlan = currentPlan
            currentPlan = selectedPlan
            dismiss.toggle()
        }

        let secondary = AlertAction(title: "Cancel", role: .cancel) { [weak self] in
            self?.dismiss.toggle()
        }

        return AlertModel(
            title: "Warning!",
            message: "Your selected plan has changed. Would you like to subscribe before leaving?",
            primaryAction: primary,
            secondaryAction: secondary
        )
    }

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        selectedPlan = currentPlan
    }

    func didSubscribe() {
        previousPlan = currentPlan
        currentPlan = selectedPlan
        newAlert = successAlert
    }

    func didRestore() {
        guard let restored = previousPlan else {
            newAlert = restoreFailureAlert
            return
        }
        selectedPlan = restored
        previousPlan = currentPlan
        currentPlan = restored
        newAlert = restoreSuccessAlert
    }

    func didTapDismiss() {
        if currentPlan != selectedPlan {
            newAlert = dismissAlert
        } else {
            dismiss.toggle()
        }
    }
}
