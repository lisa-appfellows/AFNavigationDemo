//
//  CategoryFeed.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import SwiftUI

struct CategoryFeed: View {
    @Environment(\.targetedAd) private var targetedAd
    let category: String

    @State private var targetedAdIsVisible = true

    var body: some View {
        ScrollView {
            if targetedAdIsVisible {
                TargetedAdBanner(
                    model: targetedAd,
                    onAction: didTapTargetedAd,
                    onDismiss: didDismissTargetedAd
                )
            }

            VStack(spacing: 20) {
                ForEach(0...4, id: \.self) { index in
                    MetadataView(
                        article: .mock(category: category, index: index),
                        articleType: .feed,
                        action: didTapArticle
                    )
                    .padding(.bottom)
                }
            }
            .padding()
        }
    }

    private func didTapArticle() {}
    private func didTapTargetedAd() {}
    private func didDismissTargetedAd() {
        withAnimation {
            targetedAdIsVisible = false
        }
    }
}

#Preview {
    CategoryFeed(category: MockCategory.tech.title)
        .environment(\.targetedAd, BaselineJoyAd.model)
}
