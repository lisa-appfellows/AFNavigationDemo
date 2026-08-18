//
//  BaselineJoyViewModel.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import AFNavigationKit
import SwiftUI

@Observable
final class BaselineJoyViewModel {
    var newAlert: AlertModel?

    private var vacationAlert: AlertModel {
        let primary = AlertAction(title: "OK", role: .cancel) {}
        return .init(
            title: "So Sorry!",
            message: "All of our AI Agents are currently on vacation. Please check back with us once we are back online.",
            primaryAction: primary
        )
    }

    func didTapAdAction() {
        newAlert = vacationAlert
    }
}
