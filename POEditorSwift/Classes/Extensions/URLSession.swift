//
//  URLSession.swift
//  POEditor-Swift
//
//  Created by Giuseppe Travasoni on 10/04/2020.
//

import Foundation

extension URLSession {
    func perform<T>(request urlRequest: URLRequest, type: T.Type, completion: @escaping ((T?, Error?) -> Void)) where T : Decodable {
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil, let data = data else {
                DispatchQueue.main.async { completion(nil, error) }
                return
            }
            do {
                let object: T = try JSONDecoder.decoder.decode(T.self, from: data)
                DispatchQueue.main.async { completion(object, nil) }
            } catch {
                DispatchQueue.main.async { completion(nil, error) }
            }
        }.resume()
    }
}
