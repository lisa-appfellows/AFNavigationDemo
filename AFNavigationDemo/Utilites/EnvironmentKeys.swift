//
//  EnvironmentKeys.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import SwiftUI

//NOTE: Architectural shortcuts for demonstration purposes.
 
struct TargetedAdKey: EnvironmentKey {
    static var defaultValue: TargetedAdBannerModel = SubscriptionSignUpView.model
}

struct ArticleCategoriesKey: EnvironmentKey {
    static var defaultValue: [String] = MockCategory.allCases.map { $0.title }
}

extension EnvironmentValues {
    var targetedAd: TargetedAdBannerModel {
        get { self[TargetedAdKey.self] }
        set { self[TargetedAdKey.self] = newValue }
    }

    var articleCategories: [String] {
        get { self[ArticleCategoriesKey.self] }
        set { self[ArticleCategoriesKey.self] = newValue }
    }
}
