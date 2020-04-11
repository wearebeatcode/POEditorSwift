//
//  APIService.swift
//  POEditor-Swift
//
//  Created by Giuseppe Travasoni on 10/04/2020.
//

import Foundation

public enum APIError: Error {
    case internalError
    case unknown
}

class APIService {
    
    private enum ParameterKeys: String {
        case apiToken = "api_token"
        case projectId = "id"
        case language = "language"
        case type = "type"
    }
    
    private let baseUrl = "https://api.poeditor.com/v2/"
    private let apiKey: String
    
    internal init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func getProjects(_ completion: @escaping ((Result<[Project], Error>) -> Void)) {
        guard let request = URLRequest.request(with: baseUrl, path: "projects/list",
                                               parameters: [ParameterKeys.apiToken.rawValue: apiKey],
                                               method: .POST) else {
            completion(.failure(APIError.internalError))
            return
        }
        URLSession.shared.perform(request: request, type: ProjectsResponse.self) { response, error in
            guard error == nil, let response = response else {
                completion(.failure(error ?? APIError.unknown))
                return
            }
            if let responseError = response.response.error {
                completion(.failure(responseError))
                return
            }
            completion(.success(response.result.projects))
        }
    }
    
    func getLanguages(for projectId: Int, completion: @escaping ((Result<[TranslationLanguage], Error>) -> Void)) {
        guard let request = URLRequest.request(with: baseUrl, path: "languages/list",
                                               parameters: [ParameterKeys.apiToken.rawValue: apiKey,
                                                            ParameterKeys.projectId.rawValue: "\(projectId)"],
                                               method: .POST) else {
            completion(.failure(APIError.internalError))
            return
        }
        URLSession.shared.perform(request: request, type: LanguagesResponse.self) { response, error in
            guard error == nil, let response = response else {
                completion(.failure(error ?? APIError.unknown))
                return
            }
            if let responseError = response.response.error {
                completion(.failure(responseError))
                return
            }
            completion(.success(response.result.languages))
        }
    }
    
    func exportProject(for projectId: Int, language: String, completion: @escaping ((Result<String, Error>) -> Void)) {
        guard let request = URLRequest.request(with: baseUrl, path: "projects/export",
                                               parameters: [ParameterKeys.apiToken.rawValue: apiKey,
                                                            ParameterKeys.projectId.rawValue: "\(projectId)",
                                                            ParameterKeys.language.rawValue : language,
                                                            ParameterKeys.type.rawValue : "key_value_json"],
                                               method: .POST) else {
            completion(.failure(APIError.internalError))
            return
        }
        URLSession.shared.perform(request: request, type: ProjectExportResponse.self) { response, error in
            guard error == nil, let response = response else {
                completion(.failure(error ?? APIError.unknown))
                return
            }
            if let responseError = response.response.error {
                completion(.failure(responseError))
                return
            }
            completion(.success(response.result.url))
        }
    }
    
    func getTranslations(for url: String, completion: @escaping ((Result<[String: String], Error>) -> Void)) {
        guard let request = URLRequest.request(with: url, path: nil, method: .GET) else {
            completion(.failure(APIError.internalError))
            return
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil, let data = data else {
                DispatchQueue.main.async { completion(.failure(error ?? APIError.unknown)) }
                return
            }
            if let response = try? JSONDecoder.decoder.decode(APIResponse.self, from: data) {
                completion(.failure(response.error ?? APIError.unknown))
                return
            }
            if let translations = try? JSONDecoder.decoder.decode([String: String].self, from: data) {
                completion(.success(translations))
                return
            }
            completion(.failure(APIError.unknown))
        }.resume()
    }
}
