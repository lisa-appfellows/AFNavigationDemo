//
//  BaselineJoyAction.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import Foundation

enum BaselineJoyAction: CaseIterable {
    case calibrate
    case caseStudies
    case verification
    case methodology

    var iconName: String {
        switch self {
        case .calibrate: "list.bullet"
        case .caseStudies: "flask"
        case .verification: "photo"
        case .methodology: "eye"
        }
    }

    var title: String {
        switch self {
        case .calibrate:
            return "Calibrate Emotional Diagnostics"
        case .caseStudies:
            return "Empirical Case Studies"
        case .verification:
            return "Photographic Verification Core"
        case .methodology:
            return "Autonomous Agent Methodology"
        }
    }
}
