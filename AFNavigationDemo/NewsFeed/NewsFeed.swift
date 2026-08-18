//
//  NewsFeed.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import SwiftUI

enum TopicSection {
    case topic(String)
    case ad

    var id: String {
        switch self {
        case .topic(let category): return category
        case .ad: return "ad"
        }
    }
}

struct NewsFeed: View {
    @Environment(Coordinator.self) private var coordinator
    @Environment(\.articleCategories) private var categories
    @Environment(\.targetedAd) private var targetedAd

    @State private var targetedAdIsVisible = true
    private var topicSections: [TopicSection] {
        var topics = categories.map { TopicSection.topic($0) }
        if topics.count > 2 {
            topics.insert(.ad, at: 2)
        } else {
            topics.append(.ad)
        }
        return topics
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ForEach(topicSections, id: \.id) { topic in
                    switch topic {
                    case .ad:
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
                    case .topic(let category):
                        NewsFeedSection(category: category)
                    }
                }
            }
            .padding(.vertical)
        }

        .navigationTitle("News Feed")
        .toolbarTinted()
    }
}

#Preview {
    NewsFeed()
        .environment(Coordinator())
}
