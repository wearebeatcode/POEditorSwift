//
//  POEditor.swift
//  POEditor-Swift
//
//  Created by Giuseppe Travasoni on 10/04/2020.
//

import Foundation

public struct POEditor {
    
    public enum POEditorError: Error {
        case notStarted
    }
    
    private static var apiService: APIService?
    private(set) static var translationService: TranslationService?
    
    public static func start(withKey apiKey: String) {
        self.apiService = APIService(apiKey: apiKey)
    }
    
    public static func updateLanguages(for projectId: Int, completion: @escaping ((Error?) -> Void)) throws {
        guard let apiService = apiService else {
            throw POEditorError.notStarted
        }
        let translationService = TranslationService(projectId: projectId, apiService: apiService)
        self.translationService = translationService
        translationService.updateLanguages(completion)
    }
    
    public static func getProjects(_ completion: @escaping ((Result<[Project], Error>) -> Void)) {
        guard let apiService = apiService else {
            completion(.failure(POEditorError.notStarted))
            return
        }
        apiService.getProjects(completion)
    }
}
