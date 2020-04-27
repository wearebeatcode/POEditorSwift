//
//  LanguagesResponse.swift
//  MakeIdentity
//
//  Created by Giuseppe Travasoni on 10/04/2020.
//  Copyright © 2020 Beatcode. All rights reserved.
//

import Foundation

internal struct LanguagesResponse: Codable {
    let response: APIResponse
    let result: LanguageResult
}

internal struct LanguageResult: Codable {
    let languages: [TranslationLanguage]
}

internal struct TranslationLanguage: Codable {
    let name, code: String
    let translations, percentage: Int
    let updated: Date?
}
