//
//  URLRequestBuilder.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 01/07/22.
//

import Foundation

class URLRequestBuilder {
    private var request: URLRequest
    
    init(url: URL) {
        request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    func httpMethod(_ method: HttpMethod) -> URLRequestBuilder {
        request.httpMethod = method.rawValue
        return self
    }
    
    func addHeader(key: String, value: String) -> URLRequestBuilder {
        request.addValue(key, forHTTPHeaderField: value)
        return self
    }
    
    func build() -> URLRequest { return request }
}
