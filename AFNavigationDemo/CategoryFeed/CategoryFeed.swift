//
//  CategoryFeed.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import SwiftUI

struct CategoryFeed: View {
    @Environment(Coordinator.self) private var coordinator
    @Environment(\.targetedAd) private var targetedAd
    let category: String

    @State private var targetedAdIsVisible = true

    var body: some View {
        ScrollView {
            VStack(spacing: 48) {
                let hero = Article.mock(category: category, index: 0)
                MetadataView(
                    article: hero,
                    articleType: .feed
                ) {
                    coordinator.present(cover: .articlePage(hero))
                }

                if targetedAdIsVisible {
                    TargetedAdBanner(
                        model: targetedAd) {
                            coordinator.present(
                                sheet: .targetedAd(urlString: targetedAd.adURL)
                            )
                        } onDismiss: {
                            withAnimation {
                                targetedAdIsVisible = false
                            }
                        }
                }
                
                ForEach(1...4, id: \.self) { index in
                    let article = Article.mock(category: category, index: index)
                    MetadataView(
                        article: article,
                        articleType: .feed
                    ) {
                        coordinator.present(cover: .articlePage(article))
                    }
                }
            }
            .padding()
        }
        .navigationTitle(category)
        .toolbarTinted()
    }
}

#Preview {
    CategoryFeed(category: MockCategory.technology.title)
        .environment(Coordinator())
        .environment(\.targetedAd, BaselineJoyAd.model)
}
