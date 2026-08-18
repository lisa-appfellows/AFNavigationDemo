//
//  TargetedAdRegistry.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import SwiftUI

enum TargetedAdRegistry: String {
    case subscription = "/subscription"
    case baselineJoy = "/baselineJoy"

    @ViewBuilder
    var adView: some View {
        switch self {
        case .subscription:
            SubscriptionSignUpView()
        case .baselineJoy:
            BaselineJoyAd()
        }
    }
}
