//
//  CoordinatorView.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-15.
//

import AFNavigationKit
import SwiftUI

typealias Coordinator = BasicCoordinator<Page, Cover, Sheet>

struct CoordinatorView: View {
    @State private var coordinator = Coordinator()

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            NewsFeed()
                .navigationDestination(for: Page.self) { page in
                    PageFactory.createView(for: page)
                }
                .fullScreenCover(item: $coordinator.cover) { cover in
                    CoverFactory.createView(for: cover)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    SheetFactory.createView(for: sheet)
                }
        }
        .tint(.appTint)
        .environment(coordinator)
    }
}

#Preview {
    CoordinatorView()
        .environment(Coordinator())
}
