//
//  ProjectsResponse.swift
//  POEditor-Swift
//
//  Created by Giuseppe Travasoni on 10/04/2020.
//

import Foundation

internal struct ProjectsResponse: Codable {
    let response: APIResponse
    let result: ProjectsResult
}

internal struct ProjectsResult: Codable {
    let projects: [Project]
}
