//
//  ArticleImage.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import ImageIO
import SwiftUI

struct ArticleImage: View {
    private let assetName: String
    private let articleType: ArticleType

    @State private var loadedImage: UIImage? = nil
    
    private var height: CGFloat {
        switch articleType {
        case .carousel: 120
        case .feed: 180
        case .page: 240
        }
    }

   private var cornerRadius: CGFloat {
        switch articleType {
        case .carousel: 8
        case .feed: 10
        case .page: 0
        }
    }

    init(assetName: String, articleType: ArticleType) {
        self.assetName = assetName
        self.articleType = articleType
    }

    var body: some View {
        Group {
            if let loadedImage {
                Image(uiImage: loadedImage)
                    .resizable()
                    .scaledToFill()
            } else {
                Color.gray.opacity(0.1)
            }
        }
        .frame(height: height)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .task(id: assetName) {
            loadedImage = await ImageDownsampler.downsample(named: assetName, toHeight: height)
        }
    }
}

#Preview {
    ArticleImage(assetName: MockCategory.technology.assets[0], articleType: .carousel)
}
