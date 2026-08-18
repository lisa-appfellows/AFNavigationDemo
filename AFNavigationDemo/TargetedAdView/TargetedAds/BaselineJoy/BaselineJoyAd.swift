//
//  BaselineJoyAd.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import SwiftUI

struct BaselineJoyAd: View {
    @ScaledMetric(relativeTo: .caption2)
    private var disclaimerFontSize: CGFloat = 8

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                Image(.joy)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 260)
                    .frame(maxWidth: .infinity)
                    .clipped()
                
                VStack(spacing: 24) {
                    Capsule()
                        .fill(Color.clear)
                        .frame(width: 36, height: 5)
                        .padding(.top, 12)
                    
                    VStack(spacing: 8) {
                        Text("Unlock Your Baseline Joy.")
                            .font(.custom("Cochin-BoldItalic", size: 26))
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.center)
                        
                        Text("Backed by distributed behavioral AI models.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 24)
                    
                    VStack(spacing: 12) {
                        IconCard(systemImage: "list.bullet", caption: "Calibrate Emotional Diagnostics") {}
                        IconCard(systemImage: "flask", caption: "Empirical Case Studies") {}
                        IconCard(systemImage: "photo", caption: "Photographic Verification Core") {}
                        IconCard(systemImage: "eye", caption: "Autonomous Agent Methodology") {}
                    }
                    .padding(.horizontal, 16)
                    
                    VStack(spacing: 6) {
                        Text("LEGAL & ALGORITHMIC COMPLIANCE")
                            .font(.system(size: disclaimerFontSize - 1, weight: .bold))
                            .kerning(1)
                            .foregroundStyle(.secondary.opacity(0.8))
                        
                        Text("These statements have not been evaluated by human behavioral scientists. Tactile anchors do not contain processing units, wireless receivers, or microchips, and are entirely non-functional without manual human enclosure.")
                            .font(.system(size: disclaimerFontSize))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary.opacity(0.7))
                            .lineSpacing(3)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                    .padding(.bottom, 32)
                }
                .background(
                    UnevenRoundedRectangle(topLeadingRadius: 24, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 24)
                        .fill(Color(.systemBackground))
                        .shadow(color: Color.black.opacity(0.04), radius: 12, x: 0, y: -6)
                )
                .offset(y: -24)
                .padding(.bottom, -24)
            }
        }
        .background(Color(.systemBackground).ignoresSafeArea())
    }
}

struct IconCard: View {
    let systemImage: String
    let caption: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: systemImage)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.white)
                    .frame(width: 34, height: 34)
                    .background(.tint, in: RoundedRectangle(cornerRadius: 8))
                
                Text(caption)
                    .font(.system(size: 14, weight: .medium, design: .serif))
                    .foregroundStyle(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(.secondary.opacity(0.4))
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.primary.opacity(0.05), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    BaselineJoyAd()
}
