//
//  ArticlePage.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import SwiftUI

struct ArticlePage: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.targetedAd) private var targetedAd
    @Environment(ArticleCoordinator.self) private var articleCoordinator

    let article: Article

    @State private var targetedAdIsVisible = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                MetadataView(article: article, articleType: .page)
                    .padding(.bottom, 24)
                
                if targetedAdIsVisible {
                    TargetedAdBanner(model: targetedAd) {
                        articleCoordinator.present(
                            sheet: .targetedAd(urlstring: targetedAd.adURL)
                        )
                    } onDismiss: {
                        withAnimation {
                            targetedAdIsVisible = false
                        }
                    }
                }

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
        .toolbarTinted()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text(article.category).bold()
            }

            ToolbarItem(placement: .topBarTrailing) {
                ToolbarButton.close { dismiss() }
            }
        }
    }
}

#Preview {
    ArticlePage(
        article: .mock(
            category: MockCategory.technology.rawValue,
            index: 0
        )
    )
    .environment(ArticleCoordinator())
    .environment(\.targetedAd, BaselineJoyAd.model)
}
