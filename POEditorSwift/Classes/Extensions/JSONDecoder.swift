//
//  JSONDecoder.swift
//  POEditor-Swift
//
//  Created by Giuseppe Travasoni on 10/04/2020.
//

import Foundation

extension JSONDecoder {
    
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.formatter)
        return decoder
    }
}
