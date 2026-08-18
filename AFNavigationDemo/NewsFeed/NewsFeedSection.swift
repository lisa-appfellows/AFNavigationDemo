//
//  NewsFeedSection.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import SwiftUI

struct NewsFeedSection: View {
    @Environment(Coordinator.self) private var coordinator
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
                        let article = Article.mock(category: category, index: index)
                        MetadataView(
                            article: article,
                            articleType: .carousel
                        ) {
                            coordinator.present(cover: .articlePage(article))
                        }
                        .frame(width: 220)
                    }
                }
                .padding(.horizontal)
            }
            
            HStack {
                Spacer()
                Button {
                    coordinator.push(page: .categoryFeed(category))
                } label: {
                    Text("See all \(category) posts →")
                        .font(.caption.bold())
                }
                .padding(.horizontal)
            }
            .padding(.top, 8)
        }
        .padding(.bottom)
    }

    private func didTapSeeAll() {}
}
