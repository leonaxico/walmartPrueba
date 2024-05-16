//
//  ProductRequests.swift
//  walmartDemo
//
//  Created by Axel Iván Solano González on 15/05/24.
//

import Foundation

class ProductRequestsManager {
    
    func products(completion: @escaping ([Product]?, Error?) -> Void) {
        request(.getProducts, genericType: [Product].self, completionHandler: {(logginResponse, error) in
            completion(logginResponse, error)
            }
        )
    }
        
    func productID(id: String, completion: @escaping (Product?, Error?) -> Void) {
        request(.getProductByID, genericType: Product.self,urlParam: id,completionHandler: {(product, error) in
            completion(product, error)
            }
        )
    }
    
    func newProduct(product:Product, completion: @escaping (Product?, Error?) -> Void) {
        request(.newProduct, genericType: Product.self,  body: product.toMap(), completionHandler: {(product, error) in
            completion(product, error)
            }
        )
    }
    
    func updateProduct(id: String, product:Product, completion: @escaping (Product?, Error?) -> Void) {
        request(.updateProduct, genericType: Product.self, body: product.toMap(), urlParam: id, completionHandler: {(product, error) in
            completion(product, error)
            }
        )
    }
    
    func deleteProduct(id: String, completion: @escaping (Product?, Error?) -> Void) {
        request(.deleteProduct, genericType: Product.self,urlParam: id,completionHandler: {(product, error) in
            completion(product, error)
            }
        )
    }
    
    func request<T: Codable>(_ apiUrl: RequestCases, genericType: T.Type,body: [String:Any]? = nil,urlParam: String = "", completionHandler: @escaping(_ result: T?, Error?) -> Void) {
        if let url = URL(string: apiUrl.url + (urlParam)) {
            if let body: [String:Any] = body {
                do {
                    var request = URLRequest(url: url)
                    request.httpMethod = apiUrl.httpMethod.rawValue
                    request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                    URLSession.shared.dataTask(with: request) { (data, response, error) in
                        if error != nil {
                            completionHandler(nil, error as NSError?)
                        }else{
                            if let data = data, let response = try? JSONDecoder().decode(T.self, from: data) {
                                completionHandler(response, nil)
                            } else {
                                completionHandler(nil, error as NSError?)
                            }
                        }
                    }.resume()
                } catch let error {
                    print(error.localizedDescription)
                    completionHandler(nil, error as NSError)
                }
            }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    completionHandler(nil, error as NSError?)
                }else{
                    if let data = data, let response = try? JSONDecoder().decode(T.self, from: data) {
                        completionHandler(response , nil)
                    } else {
                        completionHandler(nil, error as NSError?)
                    }
                }
            }.resume()
        }
    }

}
