//
//  ProjectExportResponse.swift
//  POEditor-Swift
//
//  Created by Giuseppe Travasoni on 10/04/2020.
//

import Foundation

struct ProjectExportResponse: Codable {
    let response: APIResponse
    let result: ProjectExportResult
}

struct ProjectExportResult: Codable {
    let url: String
}
