//
//  MetadataView.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import SwiftUI

struct MetadataView: View {
    let article: Article
    let articleType: ArticleType
    let action: (() -> Void)?

    init(
        article: Article,
        articleType: ArticleType,
        action: (() -> Void)? = nil
    ) {
        self.article = article
        self.articleType = articleType
        self.action = action
    }

    var body: some View {
        if let action = action {
            Button(action: action) {
                innerContent
            }
            .buttonStyle(.plain)
        } else {
            innerContent
        }
    }

    private var innerContent: some View {
        VStack {
            ArticleImage(assetName: article.imageName, articleType: articleType)
            if articleType == .page {
                MetadataTextView(article: article, articleType: articleType)
                    .padding(.horizontal)
            } else {
                MetadataTextView(article: article, articleType: articleType)
            }
        }
    }
}
