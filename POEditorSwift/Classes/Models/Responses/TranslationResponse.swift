//
//  LanguageResponse.swift
//  POEditor-Swift
//
//  Created by Giuseppe Travasoni on 10/04/2020.
//

import Foundation

struct TranslationResponse: Codable {
    let response: APIResponse?
    let translations: [String: String]?
}
