//
//  Article.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import SwiftUI

struct Article: Hashable {
    let id = UUID().uuidString
    let imageName: String
    let category: String
    let title: String
    let publishedDate: Date
    let description: String
    let body: [ArticleBody]

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Article, rhs: Article) -> Bool {
        lhs.id == rhs.id
    }
}

enum ArticleBody: Identifiable {
    case heading(id: UUID = UUID(), text: String)
    case paragraph(id: UUID = UUID(), text: String)

    var id: UUID {
        switch self {
        case .heading(let id, _), .paragraph(let id, _):
            return id
        }
    }

    var text: String {
        switch self {
        case .heading(_, let text), .paragraph(_, let text):
            return text
        }
    }
}
