//
//  URLComponentsBuilder.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 01/07/22.
//

import Foundation

class URLComponentsBuilder {
    private var components: URLComponents
    private var baseURL: String
    private lazy var endpoint = baseURL
    init(baseURL: String) {
        self.baseURL = baseURL
        components = URLComponents(string: baseURL)!
    }
    
    func path(_ string: String) -> URLComponentsBuilder {
        endpoint = endpoint + string
        components = URLComponents(string: endpoint)!
        return self
    }
    
    func addQuery(key: String, value: String?) -> URLComponentsBuilder {
        guard let value = value else { return self }
        initQueryItemIfNeeded()
        let queryItem = URLQueryItem(name: key, value: value)
        components.queryItems?.append(queryItem)
        return self
    }
    
    func addQuery(key: String, value: Int?) -> URLComponentsBuilder {
        guard let value = value else { return self }
        return addQuery(key: key, value: value)
    }
    
    func addQuery(key: String, value: Bool?) -> URLComponentsBuilder {
        guard let value = value else { return self }
        return addQuery(key: key, value: value)
        
    }
    
    func build() -> URLComponents { return components }
    func buildUrl() -> URL? { return components.url }
    
    private func initQueryItemIfNeeded() {
        if components.queryItems == nil {
            components.queryItems = []
        }
    }
}
