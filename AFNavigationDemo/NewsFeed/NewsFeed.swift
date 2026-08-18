//
//  NewsFeed.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import SwiftUI

struct NewsFeed: View {
    @Environment(\.articleCategories) private var categories
    @Environment(\.targetedAd) private var targetedAd

    @State private var targetedAdIsVisible = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                if targetedAdIsVisible {
                    TargetedAdBanner(
                        model: targetedAd,
                        onAction: didTapTargetedAd,
                        onDismiss: didDismissTargetedAd
                    )
                }

                ForEach(categories, id: \.self) { category in
                    NewsFeedSection(category: category)
                }
            }
            .padding(.vertical)
        }
    }

    private func didTapTargetedAd() {}
    private func didDismissTargetedAd() {
        withAnimation {
            targetedAdIsVisible = false
        }
    }
}

#Preview {
    NewsFeed()
}
