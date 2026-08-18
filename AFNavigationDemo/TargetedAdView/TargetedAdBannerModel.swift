//
//  TargetedAdBannerModel.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import Foundation

enum AdFont {
    case custom(String)
    case system
}

enum SubheadingStyle { case subheading, caption }

struct TargetedAdBannerModel {
    let systemName: String
    let tintName: String
    let adFont: AdFont
    let heading: String
    let subheading: String
    let subheadingStyle: SubheadingStyle
    let cta: String
    let legalDisclaimer: LegalDisclaimer?
    let adURL: String

    init(
        systemName: String,
        tintName: String,
        adFont: AdFont,
        heading: String,
        subheading: String,
        subheadingStyle: SubheadingStyle,
        cta: String,
        legalDisclaimer: LegalDisclaimer? = nil,
        adURL: String
    ) {
        self.systemName = systemName
        self.tintName = tintName
        self.adFont = adFont
        self.heading = heading
        self.subheading = subheading
        self.subheadingStyle = subheadingStyle
        self.cta = cta
        self.legalDisclaimer = legalDisclaimer
        self.adURL = adURL
    }
}
