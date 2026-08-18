//
//  TargetedAdCoordinator.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import SwiftUI

struct TargetedAdCoordinator<AdContent: View>: View {
    let adContent: () -> AdContent

    var body: some View {
        NavigationStack {
            adContent()
        }
    }
}

#Preview {
    TargetedAdCoordinator<BaselineJoyAd> {
        BaselineJoyAd()
    }
}
