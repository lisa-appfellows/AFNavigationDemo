//
//  LegalDisclaimer.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import Foundation

struct LegalDisclaimer {
    let title: String?
    let banner: String
    let body: String

    init(title: String? = nil, banner: String, body: String) {
        self.title = title
        self.banner = banner
        self.body = body
    }
}
