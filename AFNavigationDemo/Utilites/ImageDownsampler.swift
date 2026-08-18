//
//  ImageDownsampler.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import UIKit
import ImageIO

struct ImageDownsampler {
    static func downsample(named name: String, toHeight height: CGFloat) async -> UIImage? {
        return await Task.detached(priority: .userInitiated) {
            guard let originalImage = UIImage(named: name) else { return nil }
            
            let scale = await UIScreen.main.scale
            let targetHeight = height * scale
            
            guard originalImage.size.height > targetHeight else { return originalImage }
            
            let aspectRatio = originalImage.size.width / originalImage.size.height
            let targetSize = CGSize(width: targetHeight * aspectRatio, height: targetHeight)
            
            let format = UIGraphicsImageRendererFormat()
            format.scale = scale
            format.opaque = false
            
            let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)
            let resizedImage = renderer.image { _ in
                originalImage.draw(in: CGRect(origin: .zero, size: targetSize))
            }
            
            return resizedImage
        }.value
    }
}
