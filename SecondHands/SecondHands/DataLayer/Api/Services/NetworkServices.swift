//
//  NetworkServices.swift
//  SecondHands
//
//  Created by Adji Firmansyah on 01/07/22.
//

import UIKit
import Alamofire

enum HttpMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum UserEndpoint: String {
    case seller = "/seller"
    case buyer = "/buyer"
}

enum ItemEndpoint: String {
    case product = "/product"
    case order = "/order"
    case category = "/category"
    case banner = "/banner"
}

class NetworkServices {
//    /buyer/product
    let baseUrl = "https://market-final-project.herokuapp.com"
    
    func authLogin(email: String, password: String, completion: @escaping (Result<UserLoginModel, Error>) -> Void) {
        let endPoint = self.baseUrl
        
        let bodyData = """
        {
            "email" : "\(email)",
            "password" : "\(password)"
        }
        """.data(using: String.Encoding.utf8)!
//        print(bodyData.data(using: String.Encoding.utf8)!)
        guard let urlComponents = URLComponentsBuilder(baseURL: endPoint)
                .path("/auth")
                .path("/login")
                .buildUrl()
        else { return }
        
        let urlRequest = URLRequestBuilder(url: urlComponents)
            .httpMethod(.POST)
//            .addHeader(key: <#T##String#>, value: "content-type")
            .addBody(data: bodyData)
            .build()
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            let repson = response as? HTTPURLResponse
            
            guard let data = data else { return }
            if let error = error {
                print(error.localizedDescription)
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let jsonSerial = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("jSON serial" , jsonSerial)
                let session = try jsonDecoder.decode(UserLoginModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(session))
                }
                
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getBanner(completion: @escaping(Result<[OfferItem], Error>) -> Void) {
        let endPoint = self.baseUrl
        
        // MARK: - INI URL
        guard let urlcomponents = URLComponentsBuilder(baseURL: endPoint)
            .path("/seller")
            .path("/banner")
            .buildUrl()
        else { return }
        
        // MARK: - PRINT URL KESELURUHAN
        print(urlcomponents)
        
        let urlRequest = URLRequestBuilder(url: urlcomponents)
            .httpMethod(.GET)
            .build()
//        print(urlRequest.url)
        let jsonDecoder = JSONDecoder()
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            if let error = error {
                print(error.localizedDescription)
            }
            
            do {
                let session = try jsonDecoder.decode([OfferItem].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(session))
                }
                
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getCategory(completion: @escaping(Result<[Categories], Error>) -> Void) {
        let endPoint = self.baseUrl
        
        guard let urlcomponents = URLComponentsBuilder(baseURL: endPoint)
            .path("/seller")
            .path("/category")
            .buildUrl()
        else { return }
        let urlRequest = URLRequestBuilder(url: urlcomponents)
            .httpMethod(.GET)
            .build()
//        print(urlRequest.url)
        let jsonDecoder = JSONDecoder()
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            if let error = error {
                print(error.localizedDescription)
            }
            
            do {
                let session = try jsonDecoder.decode([Categories].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(session))
                }
                
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getProduct(by user: UserEndpoint, completion: @escaping(Result<[ProductItem], Error>) -> Void) {
        let endPoint = self.baseUrl
        
        guard let urlcomponents = URLComponentsBuilder(baseURL: endPoint)
            .path(user.rawValue)
            .path("/product")
            .buildUrl()
        else { return }
        let urlRequest = URLRequestBuilder(url: urlcomponents)
            .httpMethod(.GET)
            .build()
//        print(urlRequest.url)
        let jsonDecoder = JSONDecoder()
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            if let error = error {
                print(error.localizedDescription)
            }
            
            do {
                let session = try jsonDecoder.decode([ProductItem].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(session))
                }
                
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
        
    }
    
    func getItem( ) {
        
    }
}
