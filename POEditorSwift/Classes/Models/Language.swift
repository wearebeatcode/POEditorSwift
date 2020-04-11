//
//  LanguageModel.swift
//  MakeIdentity
//
//  Created by Giuseppe Travasoni on 10/04/2020.
//  Copyright © 2020 Beatcode. All rights reserved.
//

import Foundation

public struct Language: Codable {
    let translations: [String: String]
    let lastUpdate: Date
    let code: String
}

