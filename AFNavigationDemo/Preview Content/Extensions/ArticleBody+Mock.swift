//
//  ArticleBody+Mock.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

#if DEBUG
import Foundation

extension ArticleBody {
    static var mockHeading: ArticleBody {
        .heading(text: "Lorem ipsum dolor sit.")
    }

    static var mockParagraph: ArticleBody {
        .paragraph(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur sed vestibulum sapien. Ut dictum ligula non vulputate fermentum. In finibus tellus eget nisl aliquet, at hendrerit turpis sodales.")
    }
}
#endif
