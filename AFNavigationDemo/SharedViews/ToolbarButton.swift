//
//  ToolbarButton.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import SwiftUI

struct ToolbarButton: View {
    let systemName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
        }
    }
}

extension ToolbarButton {
    static func close(action: @escaping () -> Void) -> ToolbarButton {
        .init(systemName: "xmark", action: action)
    }
}

