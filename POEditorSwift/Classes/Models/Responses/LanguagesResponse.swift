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
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        self.code = try values.decode(String.self, forKey: .code)
        self.translations = try values.decode(Int.self, forKey: .translations)
        self.percentage = try values.decode(Int.self, forKey: .percentage)
        if let updatedString = try? values.decodeIfPresent(String.self, forKey: .updated), !updatedString.isEmpty {
            self.updated = DateFormatter.formatter.date(from: updatedString)
        } else {
            self.updated = nil
        }
    }
}
