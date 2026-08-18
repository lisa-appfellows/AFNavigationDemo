//
//  Styles.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import SwiftUI

enum ArticleType { case carousel, feed, page }
enum FontType { case h1, h2, body, caption }

extension View {
    func articleText(fontType: FontType, articleType: ArticleType) -> some View {
        modifier(ArticleTextModifier(fontType: fontType, articleType: articleType))
    }
}

struct ArticleTextModifier: ViewModifier {
    let fontType: FontType
    let articleType: ArticleType

    private var font: Font {
        switch (fontType, articleType) {
        case (.h1, .carousel): return .subheadline
        case (.h1, .feed): return .headline
        case (.h1, .page): return .title.bold()
        case (.h2, .page): return .title2.bold()
        case (.body, .page): return .subheadline
        case (.caption, .carousel): return .caption2
        default: return .caption
        }
    }

    
    private var foregroundStyle: AnyShapeStyle {
        switch (fontType, articleType) {
        case (.h2, .page):
            return AnyShapeStyle(.tint)
        case (.caption, _), (.body, .carousel), (.body, .feed):
            return AnyShapeStyle(.secondary)
        default:
            return AnyShapeStyle(.primary)
        }
    }

    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundStyle(foregroundStyle)
    }
}
