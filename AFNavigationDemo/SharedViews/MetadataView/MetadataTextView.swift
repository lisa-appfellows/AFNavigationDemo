//
//  MetadataTextView.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import SwiftUI

struct MetadataTextView: View {
    let article: Article
    let articleType: ArticleType

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(article.title)
                .articleText(fontType: .h1, articleType: articleType)
                .lineLimit(1)

            Text(article.publishedDate, style: .date)
                .articleText(fontType: .caption, articleType: articleType)

            if articleType != .page {
                Text(article.description)
                    .articleText(fontType: .body, articleType: articleType)
                    .lineLimit(3)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
