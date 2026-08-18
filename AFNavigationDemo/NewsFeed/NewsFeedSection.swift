//
//  NewsFeedSection.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import SwiftUI

struct NewsFeedSection: View {
    let category: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(category)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.bottom, 8)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(0...4, id: \.self) { index in
                        MetadataView(
                            article: .mock(category: category, index: index),
                            articleType: .carousel,
                            action: didTapArticle
                        )
                        .frame(width: 220)
                    }
                }
                .padding(.horizontal)
            }
            
            HStack {
                Spacer()
                Button(action: didTapSeeAll) {
                    Text("See all \(category) posts →")
                        .font(.caption.bold())
                }
                .padding(.horizontal)
            }
            .padding(.top, 8)
        }
        .padding(.bottom)
    }

    private func didTapArticle() {}
    private func didTapSeeAll() {}
}
