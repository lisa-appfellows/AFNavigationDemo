//
//  SubscriptionSignUpView+Model.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import Foundation

extension SubscriptionSignUpView {
    static var model: TargetedAdBannerModel {
        .init(
            systemName: "sparkles",
            tintName: "Subscription",
            adFont: .system,
            heading: "Upgrade to Premium",
            subheading: "Get unlimited access to deep-dive articles, custom stock tools, and zero corporate advertisements.",
            subheadingStyle: .subheading,
            cta: "See Plans",
            adURL: "/subscription"
        )
    }
}
