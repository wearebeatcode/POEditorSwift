//
//  StorageService.swift
//  POEditor-Swift
//
//  Created by Giuseppe Travasoni on 10/04/2020.
//

import Foundation

class TranslationService {
    
    private let defaults = UserDefaults.standard
    private let apiService: APIService
    private let projectId: Int
    private(set) var languages: [Language] = []
    
    private var defaultsKey: String {
        return "poeditor.\(projectId).languages"
    }
    
    internal init(projectId: Int, apiService: APIService) {
        self.projectId = projectId
        self.apiService = apiService
        loadLocalLanguages()
    }
    
    private func loadLocalLanguages() {
        guard let data = defaults.data(forKey: defaultsKey) else { return }
        languages = (try? JSONDecoder().decode([Language].self, from: data)) ?? []
    }
    
    internal func updateLanguages(_ completion: @escaping ((Error?) -> Void)) {
        apiService.getLanguages(for: projectId) { result in
            switch result {
            case .failure(let error):
                completion(error)
            case .success(let translationLanguages):
                self.updateLanguages(from: translationLanguages, completion: completion)
            }
        }
    }
    
    private func updateLanguages(from translationLanguages: [TranslationLanguage], completion: @escaping ((Error?) -> Void)) {
        let toUpdate = translationLanguages.filter { translation -> Bool in
            guard let translationUpdated = translation.updated else {
                return false
            }
            guard let localLanguage = languages.first(where: { $0.code == translation.code }) else {
                return true
            }
            return translationUpdated > localLanguage.lastUpdate
        }
        
        var foundUrls: [(TranslationLanguage, String)] = []
        let dispatch = DispatchGroup()
        toUpdate.forEach { translationLanguage in
            dispatch.enter()
            self.apiService.exportProject(for: self.projectId, language: translationLanguage.code) { result in
                switch result {
                case .failure(_):
                    dispatch.leave()
                case .success(let string):
                    foundUrls.append((translationLanguage, string))
                }
                dispatch.leave()
            }
        }
        dispatch.notify(queue: .main) {
            self.downloadTerms(for: foundUrls, completion: completion)
        }
    }
    
    private func downloadTerms(for translationLanguages: [(TranslationLanguage, String)], completion: @escaping ((Error?) -> Void)) {
        
        let dispatch = DispatchGroup()
        translationLanguages.forEach { (translationLanguage, urlString) in
            dispatch.enter()
            self.apiService.getTranslations(for: urlString) { (result) in
                switch result {
                case .failure(_):
                    dispatch.leave()
                case .success(let translations):
                    let newLanguage = Language(translations: translations, lastUpdate: translationLanguage.updated ?? Date(), code: translationLanguage.code)
                    self.languages.removeAll(where: { $0.code == newLanguage.code })
                    self.languages.append(newLanguage)
                    dispatch.leave()
                }
            }
        }
        
        dispatch.notify(queue: .main) {
            if let languagesData = try? JSONEncoder().encode(self.languages) {
                self.defaults.set(languagesData, forKey: self.defaultsKey)
            }
            completion(nil)
        }
    }
}
