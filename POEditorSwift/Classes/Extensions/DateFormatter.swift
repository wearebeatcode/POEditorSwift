//
//  DateFormatter.swift
//  POEditorSwift
//
//  Created by Giuseppe Travasoni on 27/04/2020.
//

import Foundation

extension DateFormatter {
    
    static var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        return formatter
    }
}
