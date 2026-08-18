//
//  TargetedAdCoordinator.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import AFNavigationKit
import SwiftUI

typealias TargetAdCoord = BasicCoordinator<DisabledRoute, DisabledRoute, DisabledRoute>

struct TargetedAdCoordinator<AdContent: View>: View {
    @State private var targetAdCoord = TargetAdCoord()
    let adContent: () -> AdContent

    var body: some View {
        NavigationStack {
            adContent()
        }
        .tint(.appTint)
        .openAlert(targetAdCoord)
        .environment(targetAdCoord)
    }
}

#Preview {
    TargetedAdCoordinator<BaselineJoyAd> {
        BaselineJoyAd()
    }
    .environment(TargetAdCoord())
}
