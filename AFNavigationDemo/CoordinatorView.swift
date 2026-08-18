//
//  CoordinatorView.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-15.
//

import SwiftUI

struct CoordinatorView: View {
    var body: some View {
        NavigationStack {
            NewsFeed()
        }
    }
}

#Preview {
    CoordinatorView()
}
