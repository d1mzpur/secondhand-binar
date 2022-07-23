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

enum OrderStatus: String {
    case pending = "pending"
    case accepted = "accepted"
    case declined = "declined"
}

class NetworkServices {
//    /buyer/product
    let baseUrl = "https://market-final-project.herokuapp.com"
    let userDefaults = UserDefaults.standard
    func getAccessToken() -> String {
        return userDefaults.string(forKey: "accessToken") ?? ""
    }
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
            let respon = response as? HTTPURLResponse
            print(response)
            print(respon?.statusCode)
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
    
    func authRegister(fullName: String, email: String, password: String, nav: UINavigationController, completion: @escaping (Result<UserRegister, Error>) -> Void) {
        let endPoint = self.baseUrl
        
        let bodyData = """
        {
            "full_name" : "\(fullName)",
            "email" : "\(email)",
            "password" : "\(password)"
        }
        """.data(using: String.Encoding.utf8)!
//        print(bodyData.data(using: String.Encoding.utf8)!)
        guard let urlComponents = URLComponentsBuilder(baseURL: endPoint)
                .path("/auth")
                .path("/register")
                .buildUrl()
        else { return }
        
        let urlRequest = URLRequestBuilder(url: urlComponents)
            .httpMethod(.POST)
            .addBody(data: bodyData)
            .build()
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            let _ = response as? HTTPURLResponse
            
            guard let data = data else { return }
            if let error = error {
                print(error.localizedDescription)
            }
            let jsonSerial = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print(jsonSerial)
            let jsonDecoder = JSONDecoder()
            do {
                let session = try jsonDecoder.decode(UserRegister.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(session))
                }
                
            } catch let error {
                completion(.failure(error.localizedDescription as! Error))
            }
        }.resume()
    }
    
    func getUserAlamofire(completion: @escaping (UpdateUserModel) -> Void) {
        let endPoint = self.baseUrl
//        print(bodyData.data(using: String.Encoding.utf8)!)
        guard let urlComponents = URLComponentsBuilder(baseURL: endPoint)
                .path("/auth")
                .path("/user")
                .buildUrl()
        else { return }
        
        let urlRequest = URLRequestBuilder(url: urlComponents)
            .httpMethod(.GET)
            .addHeader(value: getAccessToken(), key: "access_token")
            .build()
        
        AF.request(urlRequest).validate()
            .responseDecodable(of: UpdateUserModel.self) { result in
                if let value = result.value {
                    completion(value)
                }
                
        }
    }
    
    
    func getUser(completion: @escaping (Result<UpdateUserModel, Error>) -> Void) {
        let endPoint = self.baseUrl
        print("catch token\n", getAccessToken())
//        print(bodyData.data(using: String.Encoding.utf8)!)
        guard let urlComponents = URLComponentsBuilder(baseURL: endPoint)
                .path("/auth")
                .path("/user")
                .buildUrl()
        else { return }
        
        let urlRequest = URLRequestBuilder(url: urlComponents)
            .httpMethod(.GET)
            .addHeader(value: getAccessToken(), key: "access_token")
            .build()
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            _ = response as? HTTPURLResponse
            
            guard let data = data else { return }
            if let error = error {
                print(error.localizedDescription)
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let jsonSerial = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("jSON serial" , jsonSerial)
                let session = try jsonDecoder.decode(UpdateUserModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(session))
                }
                
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func updateProfile(image: String, fullname: String, city: String, address: String, phoneNumber: Int, completion: @escaping (Result<UpdateUserModel, Error>) -> Void) {
        let endPoint = self.baseUrl
        
        let bodyData = """
        {
            "image" : "\(image)",
            "full_name" : "\(fullname)",
            "city" : "\(city)",
            "address" : "\(address)",
            "phone_number" : "\(phoneNumber)",
        }
        """.data(using: String.Encoding.utf8)!
//        print(bodyData.data(using: String.Encoding.utf8)!)
        guard let urlComponents = URLComponentsBuilder(baseURL: endPoint)
                .path("/auth")
                .path("/user")
                .buildUrl()
        else { return }
        
        let urlRequest = URLRequestBuilder(url: urlComponents)
            .httpMethod(.POST)
            .addHeader(value: "access_token", key: getAccessToken())
            .addBody(data: bodyData)
            .build()
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            _ = response as? HTTPURLResponse
            
            guard let data = data else { return }
            if let error = error {
                print(error.localizedDescription)
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let jsonSerial = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("jSON serial" , jsonSerial)
                let session = try jsonDecoder.decode(UpdateUserModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(session))
                }
                
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getBanner(completion: @escaping([OfferItem]) -> Void) {
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
        
        AF.request(urlRequest).validate()
            .responseDecodable(of: [OfferItem].self) { result in
                if let value = result.value {
                    completion(value)
                }
                
        }
    }
    
    func getCategory(completion: @escaping([Categories]) -> Void) {
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
        
        AF.request(urlRequest).validate()
            .responseDecodable(of: [Categories].self) { result in
                if let value = result.value {
                    completion(value)
                }
                
        }
    }
    
    func getProduct(by user: UserEndpoint, completion: @escaping([ProductItem]) -> Void) {
        let endPoint = self.baseUrl
        
        guard let urlcomponents = URLComponentsBuilder(baseURL: endPoint)
            .path(user.rawValue)
            .path("/product")
            .buildUrl()
        else { return }
        var urlRequest = URLRequestBuilder(url: urlcomponents)
            .httpMethod(.GET)
            .build()
        if(user == .seller){
            urlRequest.setValue(getAccessToken(), forHTTPHeaderField: "access_token")
        }
        
        AF.request(urlRequest).validate()
            .responseDecodable(of: [ProductItem].self) { result in
                if let value = result.value {
                    completion(value)
            }
        }
        
    }	
    
    func getOrder(status: OrderStatus, completion: @escaping(Result<[OrderItem], Error>) -> Void) {
        let endPoint = self.baseUrl
        
        guard let urlcomponents = URLComponentsBuilder(baseURL: endPoint)
            .path("/seller")
            .path("/order")
            .addQuery(key: "status", value: status.rawValue)
            .buildUrl()
        else { return }
        var urlRequest = URLRequestBuilder(url: urlcomponents)
            .httpMethod(.GET)
            .build()
            urlRequest.setValue(getAccessToken(), forHTTPHeaderField: "access_token")
        
        let jsonDecoder = JSONDecoder()
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            if let error = error {
                print(error.localizedDescription)
            }
            
            do {
                let session = try jsonDecoder.decode([OrderItem].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(session))
                }
                
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
        
    }
    
    func createProduct(name: String, description: String, price: Int, category: Int, location: String, image: Data, completion: @escaping (Result<reponseProduct, Error>) -> Void) {
        let baseUrl = self.baseUrl
        let fullUrl = baseUrl + "/seller/product"
        let headers : Alamofire.HTTPHeaders = [
                    "access_token" : getAccessToken(),
                    "cache-control" : "no-cache",
                    "Accept-Language" : "en",
                    "Connection" : "close",
                    "Content-type" : "multipart/form-data"
                ]
                AF.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(image, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg");
                    multipartFormData.append(name.data(using: .utf8)!, withName: "name")
                    multipartFormData.append(description.data(using: .utf8)!, withName: "description")
                    multipartFormData.append("\(price)".data(using: .utf8)!, withName: "base_price")
                    multipartFormData.append("\(category)".data(using: .utf8)!, withName: "category_ids")
                    multipartFormData.append(location.data(using: .utf8)!,  withName: "location")
                },
                to: fullUrl, usingThreshold: .max,
                    method: .post,
                    headers: headers)
                .responseJSON(){ res in
                    print(res)
                }
                .responseDecodable(of: reponseProduct.self) { (response) in
                    switch response.result{
                    case .success(let value):
                        print("Json: \(value)")
                        completion(.success( value ))
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                }.uploadProgress { (progress) in
                    print("Progress: \(progress.fractionCompleted)")
                }
    
    }
    func getNotif(notifType: NotificationType = .all, completion: @escaping([NotifItem]) -> Void) {
        let endPoint = self.baseUrl
        
        guard let urlComponents = URLComponentsBuilder(baseURL: endPoint)
            .path("/notification")
            .addQuery(key: "notification_type", value: notifType.rawValue)
            .buildUrl()
        else { return }
        let urlRequest = URLRequestBuilder(url: urlComponents)
            .httpMethod(.GET)
            .addHeader(value: getAccessToken(), key: "access_token")
            .build()
        
        AF.request(urlRequest).validate()
            .responseDecodable(of: [NotifItem].self) { result in
                if let value = result.value {
                    completion(value)
                }
                
        }
        
//        let jsonDecoder = JSONDecoder()
//        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//            guard let data = data else { return }
//            if let error = error {
//                print(error.localizedDescription)
//            }
//
//            do {
//                let jsonSerial = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                print("jSON serial" , jsonSerial)
//                let session = try jsonDecoder.decode([NotifItem].self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(session))
//                }
//
//            } catch let error {
//                completion(.failure(error))
//            }
//        }.resume()
        
    }
    
//    func postProduct(by user: UserEndpoint, completion: @escaping(Result<[AddProductItem], Error>) -> Void){
//        let endPoint = self.baseUrl
//
////        let bodyData = """
////        {
////            "email" : "\(email)",
////            "password" : "\(password)"
////        }
////        """.data(using: String.Encoding.utf8)!
//
//        guard let urlcomponents = URLComponentsBuilder(baseURL: endPoint)
//            .path(user.rawValue)
//            .path("/product")
//            .buildUrl()
//        else { return }
//        var urlRequest = URLRequestBuilder(url: urlcomponents)
//            .httpMethod(.POST)
////            .addBody(data: bodyData)
//            .build()
//        if(user == .seller){
//            urlRequest.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImpvaG5kb2VAbWFpbC5jb20iLCJpYXQiOjE2NTQ5MjcxODZ9.fghFryd8OPEHztZlrN50PtZj0EC7NWFVj2iPPN9xi1M", forHTTPHeaderField: "access_token")
//        }
//        let jsonDecoder = JSONDecoder()
//        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//            guard let data = data else { return }
//            if let error = error {
//                print(error.localizedDescription)
//            }
//
//            do {
//                let session = try jsonDecoder.decode([AddProductItem].self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(session))
//                }
//
//            } catch let error {
//                completion(.failure(error))
//            }
//        }.resume()
//    }

    
    func getItem( ) {
        
    }
}
