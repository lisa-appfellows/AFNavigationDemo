//
//  MockCategory.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

#if DEBUG
import Foundation

enum MockCategory: String, CaseIterable {
    case technology, entertainment, politics

    var title: String { rawValue.capitalized }

    var assets: [String] {
        switch self {
        case .technology:
            return ["tech1", "tech2", "tech3", "tech4", "tech5"]
        case .entertainment:
            return ["entertainment1", "entertainment2", "entertainment3", "entertainment4", "entertainment5"]
        case .politics:
            return ["politics1", "politics2", "politics3", "politics4", "politics5"]
        }
    }
    
    init(value: String) {
        self = MockCategory(rawValue: value.lowercased()) ?? .technology
    }
}
#endif
