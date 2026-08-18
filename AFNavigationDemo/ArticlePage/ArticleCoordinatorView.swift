//
//  ArticleCoordinatorView.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import AFNavigationKit
import SwiftUI

typealias ArticleCoordinator = BasicCoordinator<DisabledRoute, DisabledRoute, ArticleSheet>

struct ArticleCoordinatorView: View {
    let article: Article

    @State private var articleCoordinator = ArticleCoordinator()

    var body: some View {
        NavigationStack {
            ArticlePage(article: article)
                .sheet(item: $articleCoordinator.sheet) { sheet in
                    ArticleSheetFactory.createView(for: sheet)
                }
        }
        .tint(.appTint)
        .environment(articleCoordinator)
    }
}

enum ArticleSheet: ValidRoute {
    case targetedAd(urlstring: String)
    var id: String {
        switch self {
        case .targetedAd(let urlstring):
            return "articleSheet_targetedAd_\(urlstring)"
        }
    }
}

enum ArticleSheetFactory: RouteFactory {
    @ViewBuilder
    static func createView(for route: ArticleSheet) -> some View {
        switch route {
        case .targetedAd(let urlstring):
            if let registered = TargetedAdRegistry(rawValue: urlstring) {
                TargetedAdCoordinator {
                    registered.adView
                }
            } else {
                EmptyView()
            }
        }
    }
}
