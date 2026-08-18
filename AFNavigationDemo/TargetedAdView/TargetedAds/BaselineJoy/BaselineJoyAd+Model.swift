//
//  BaselineJoyAd+Model.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import Foundation

extension BaselineJoyAd {
    static var model: TargetedAdBannerModel {
        .init(
            systemName: "eye.trianglebadge.exclamationmark",
            tintName: "BaselineJoy",
            adFont: .custom("Cochin-BoldItalic"),
            heading: "Unlock Your Baseline Joy.",
            subheading: "Backed by distributed behavioral AI models.",
            subheadingStyle: .caption,
            cta: "Calibrate Diagnostics",
            legalDisclaimer: .init(
                title: "LEGAL & ALGORITHMIC COMPLIANCE",
                body: "These statements have not been evaluated by human behavioral scientists."
            ),
            adURL: "/baselineJoyAd"
        )
    }
}
