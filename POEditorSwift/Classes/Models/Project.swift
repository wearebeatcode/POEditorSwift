//
//  Project.swift
//  POEditor-Swift
//
//  Created by Giuseppe Travasoni on 10/04/2020.
//

import Foundation

public struct Project: Codable {
    public let id: Int
    public let name: String
    public let projectPublic: Int
    public let projectOpen: Int
    public let created: Date

    enum CodingKeys: String, CodingKey {
        case id, name
        case projectPublic = "public"
        case projectOpen = "open"
        case created
    }
}
