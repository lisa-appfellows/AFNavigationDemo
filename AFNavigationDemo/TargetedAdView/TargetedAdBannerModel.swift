//
//  TargetedAdBannerModel.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import Foundation

enum HeadingFont {
    case custom(String)
    case system
}

enum SubheadingStyle { case subheading, caption }

struct TargetedAdBannerModel {
    let systemName: String
    let heading: String
    let subheading: String
    let cta: String
    let legalDisclaimer: LegalDisclaimer
    let adURL: String
    let tintName: String
    let headingFont: HeadingFont
    let subheadingStyle: SubheadingStyle
    let shouldShowDisclaimerOnBanner: Bool

    init(
        systemName: String,
        heading: String,
        subheading: String,
        cta: String,
        legalDisclaimer: LegalDisclaimer,
        adURL: String,
        tintName: String,
        headingFont: HeadingFont,
        subheadingStyle: SubheadingStyle,
        shouldShowDisclaimerOnBanner: Bool = false
    ) {
        self.systemName = systemName
        self.heading = heading
        self.subheading = subheading
        self.cta = cta
        self.legalDisclaimer = legalDisclaimer
        self.adURL = adURL
        self.tintName = tintName
        self.headingFont = headingFont
        self.subheadingStyle = subheadingStyle
        self.shouldShowDisclaimerOnBanner = shouldShowDisclaimerOnBanner
    }
}
