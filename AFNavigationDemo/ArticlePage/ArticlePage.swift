//
//  ArticlePage.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import SwiftUI

struct ArticlePage: View {
    let article: Article

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                MetadataView(article: article, articleType: .page)
                    .padding(.bottom, 24)

                VStack(alignment: .leading, spacing: 12) {
                    ForEach(article.body, id: \.id) { part in
                        switch part {
                        case .heading(_, let text):
                            Text(text)
                                .articleText(fontType: .h2, articleType: .page)
                                .padding(.vertical, 8)
                        case .paragraph(_, let text):
                            Text(text)
                                .articleText(fontType: .body, articleType: .page)
                                .lineSpacing(4)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    ArticlePage(
        article: .mock(
            category: MockCategory.tech.rawValue,
            index: 0
        )
    )
}
