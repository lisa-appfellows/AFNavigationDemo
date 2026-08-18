//
//  SubscriptionPlan.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import Foundation

enum SubscriptionPlan: String, CaseIterable {
    case monthly, annual, premium

    var name: String { rawValue.capitalized }

    var priceInfo: String {
        switch self {
        case .monthly: return "$4.99 / mo"
        case .annual: return "$39.99 / yr"
        case .premium: return "$9.99 / mo"
        }
    }

    var description: String {
        switch self {
        case .monthly:
            return "Flexible access, cancel anytime."
        case .annual:
            return "Best value. Save 33% overall."
        case .premium:
            return "Includes print edition & stock tools."
        }
    }
}
