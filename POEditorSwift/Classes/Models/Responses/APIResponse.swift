//
//  APIResponse.swift
//  POEditor-Swift
//
//  Created by Giuseppe Travasoni on 10/04/2020.
//

import Foundation

internal struct APIResponse: Codable {
    let status, code, message: String
    
    var error: Error? {
        if code == "200" { return nil }
        return NSError(domain: "POEditor", code: Int(code) ?? -1, userInfo: ["message": message, "status": status])
    }
}
