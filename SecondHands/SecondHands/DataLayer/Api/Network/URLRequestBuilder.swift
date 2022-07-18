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
    
    func addHeader(value: String, key: String) -> URLRequestBuilder {
        request.addValue(value, forHTTPHeaderField: key)
        return self
    }
    
//    func addBody() -> URLRequestBuilder {
//        request.httpBody = Data(base64Encoded: "application/json")
//        return self
//    }
    
    func addBody(data: Data) -> URLRequestBuilder {
        request.httpBody = data
        return self
    }
    
    func build() -> URLRequest { return request }
}
