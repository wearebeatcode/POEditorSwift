//
//  URLRequest.swift
//  POEditor-Swift
//
//  Created by Giuseppe Travasoni on 10/04/2020.
//

import Foundation

extension URLRequest {
    
    enum Method: String {
        case GET
        case POST
    }
    
    static func request(with baseUrl: String, path: String? = nil, parameters: [String: String]? = nil, method: Method) -> URLRequest? {
        guard var url = URL(string: baseUrl) else { return nil }
        if let path = path {
            url.appendPathComponent(path)
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let parameters = parameters {
            let bodyString = parameters.map({ return "\($0)=\($1)" }).joined(separator: "&")
            request.httpBody = bodyString.data(using: .utf8)
        }
        return request
    }
}
