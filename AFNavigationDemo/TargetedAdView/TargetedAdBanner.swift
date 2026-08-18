//
//  TargetedAdBanner.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import SwiftUI

struct TargetedAdBanner: View {
    let model: TargetedAdBannerModel
    var onAction: () -> Void
    var onDismiss: () -> Void

    private var tint: Color { Color(model.tintName) }
    
    private var headingFont: Font {
        switch model.headingFont {
        case .custom(let name):
            return .custom(name, size: 18, relativeTo: .body)
        case .system:
            return .headline
        }
    }

    private var subheadingText: some View {
        Text(model.subheading)
            .font(model.subheadingStyle == .subheading ? .subheadline : .caption)
            .foregroundStyle(.secondary)
    }
    
    @ScaledMetric(relativeTo: .caption2)
    private var disclaimerFontSize: CGFloat = 10
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: model.systemName)
                .font(.title2)
                .foregroundStyle(tint)
                .padding(.top, 2)
            
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(model.heading)
                        .font(headingFont)
                        .foregroundStyle(.primary)
                    
                    subheadingText
                }
                
                HStack(spacing: 16) {
                    Button(action: onAction) {
                        Text(model.cta)
                            .font(.caption)
                            .bold()
                            .foregroundStyle(tint)
                    }
                    .buttonStyle(.plain)
                    
                    Button(action: onDismiss) {
                        Text("Dismiss")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.top, 2)
                
                if model.shouldShowDisclaimerOnBanner {
                    Divider()
                        .padding(.vertical, 2)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        if let title = model.legalDisclaimer.title {
                            Text(title)
                                .font(.system(size: disclaimerFontSize - 2, weight: .bold))
                                .kerning(0.5)
                                .foregroundStyle(.secondary.opacity(0.8))
                        }
                        
                        Text(model.legalDisclaimer.banner)
                            .font(.system(size: disclaimerFontSize - 1))
                            .foregroundStyle(.secondary.opacity(0.7))
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemBackground))
        )
        .padding(.horizontal)
    }
}
