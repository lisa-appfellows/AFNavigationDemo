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
            heading: "Unlock Your Baseline Joy.",
            subheading: "Backed by distributed behavioral AI models.",
            cta: "Calibrate Diagnostics",
            legalDisclaimer: .init(
                title: "LEGAL & ALGORITHMIC COMPLIANCE",
                banner: "These statements have not been evaluated by human behavioral scientists.",
                body: "These statements have not been evaluated by human behavioral scientists. Tactile anchors do not contain processing units, wireless receivers, or microchips, and are entirely non-functional without manual human enclosure."
            ),
            adURL: "/baselineJoy",
            tintName: "BaselineJoy",
            headingFont: .custom("Cochin-BoldItalic"),
            subheadingStyle: .caption,
            shouldShowDisclaimerOnBanner: true
        )
    }
}
