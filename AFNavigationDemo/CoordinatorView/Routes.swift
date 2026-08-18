//
//  Routes.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import AFNavigationKit
import Foundation

enum Page: ValidRoute {
    case categoryFeed(String)
    var id: String {
        switch self {
        case .categoryFeed(let category):
            return "page_categoryFeed_\(category)"
        }
    }
}

enum Cover: ValidRoute {
    case articlePage(Article)
    var id: String {
        switch self {
        case .articlePage(let article):
            return "cover_articlePage_\(article.id)"
        }
    }
}

enum Sheet: ValidRoute {
    case targetedAd(urlString: String)
    var id: String {
        switch self {
        case .targetedAd(let urlString):
            return "sheet_targetedAd_\(urlString)"
        }
    }
}
