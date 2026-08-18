//
//  Article+Mock.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

#if DEBUG
import Foundation

extension Article {
    static func mock(category: String, index: Int) -> Article {
        let validCategory = MockCategory(value: category)
        let validIndex: Int = (0...4).contains(index) ? index : 0

        return .init(
            imageName: validCategory.assets[validIndex],
            category: validCategory.title,
            title: "Main Article Headline Title",
            publishedDate: .now,
            description: "This is a short three line description of the news item to show how it looks in the layout.",
            body: [
                .mockParagraph,
                .mockHeading,
                .mockParagraph,
                .mockParagraph,
                .mockHeading,
                .mockParagraph,
                .mockParagraph,
                .mockHeading,
                .mockParagraph
            ]
        )
    }
}
#endif
