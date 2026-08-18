//
//  RouteFactories.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import AFNavigationKit
import SwiftUI

enum PageFactory: RouteFactory {
    @ViewBuilder
    static func createView(for route: Page) -> some View {
        switch route {
        case .categoryFeed(let category):
            CategoryFeed(category: category)
                .environment(\.targetedAd, BaselineJoyAd.model)
        }
    }
}

enum CoverFactory:RouteFactory {
    @ViewBuilder
    static func createView(for route: Cover) -> some View {
        switch route {
        case .articlePage(let article):
            ArticleCoordinatorView(article: article)
        }
    }
}

enum SheetFactory: RouteFactory {
    @ViewBuilder
    static func createView(for route: Sheet) -> some View {
        switch route {
        case .targetedAd(let urlString):
            if let registered = TargetedAdRegistry(rawValue: urlString) {
                TargetedAdCoordinator {
                    registered.adView
                }
            } else {
                EmptyView()
            }
        }
    }
}
