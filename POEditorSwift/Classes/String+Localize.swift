//
//  String+Localize.swift
//  POEditor-Swift
//
//  Created by Giuseppe Travasoni on 10/04/2020.
//

import Foundation

public extension String {
    
    func localize() -> String {
        guard let currentLanguageCode = Locale.current.languageCode else {
            return NSLocalizedString(self, comment: "")
        }
        return localize(in: currentLanguageCode)
    }
    
    func localize(in languageCode: String) -> String {
        guard let translationService = POEditor.translationService,
            let language = translationService.languages.first(where: { $0.code == languageCode }),
            let translation = language.translations[self] else {
                return NSLocalizedString(self, comment: "")
        }
        return translation
    }
    
}
