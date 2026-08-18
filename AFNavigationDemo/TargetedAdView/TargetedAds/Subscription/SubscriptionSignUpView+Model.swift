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
            heading: "Upgrade to Premium",
            subheading: "Get unlimited access to deep-dive articles, custom stock tools, and zero corporate advertisements.",
            cta: "See Plans", 
            legalDisclaimer: .init(
                banner: "Subscriptions automatically renew unless canceled at least 24 hours before the end of the current billing cycle.",
                body: "Subscriptions automatically renew unless canceled at least 24 hours before the end of the current billing cycle."
            ),
            adURL: "/subscription",
            tintName: "Subscription",
            headingFont: .system,
            subheadingStyle: .subheading,
            shouldShowDisclaimerOnBanner: false
        )
    }
}
