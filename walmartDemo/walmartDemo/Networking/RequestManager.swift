//
//  RequestManager.swift
//  walmartDemo
//
//  Created by Axel Iván Solano González on 13/05/24.
//

import Foundation

protocol RequestsManager {
    var httpMethod: HTTPMethod { get }
    var baseURLString: String { get }
    var path: String { get }
    var headers: [String: Any]? { get }
}

extension RequestsManager {
    var url: String {
        return baseURLString + path
    }
}

enum RequestCases: RequestsManager {
    
    
    
    case getProducts
    case getProductByID
    case newProduct
    case updateProduct
    case deleteProduct
    case loggin
    case signUp
    case userData
    case uploadFile
    
    var httpMethod: HTTPMethod {
            switch self {
            case .getProducts:
                return HTTPMethod.get
            case .getProductByID:
                return HTTPMethod.get
            case .newProduct:
                return HTTPMethod.post
            case .updateProduct:
                return HTTPMethod.post
            case .deleteProduct:
                return HTTPMethod.delete
            case .loggin:
                return HTTPMethod.post
            case .signUp:
                return HTTPMethod.post
            case .userData:
                return HTTPMethod.get
            case .uploadFile:
                return HTTPMethod.post
            }
        }
        
        var baseURLString: String {
            return "http://localhost:9707/"
        }
        
        var path: String {
            switch self {
            case .getProducts:
                return "api/products"
            case .getProductByID:
                return "api/products/"
            case .newProduct:
                return "api/newProduct"
            case .updateProduct:
                return "api/updateProduct/"
            case .deleteProduct:
                return "api/delete/"
            case .loggin:
                return "api/loggin/sign-up"
            case .signUp:
                return "api/loggin/sign-up"
            case .userData:
                return "api/user/info"
            case .uploadFile:
                return "api/user/file"
                
            }
        }
        
        var headers: [String: Any]? {
            if let token = UserDefaults.standard.string(forKey: "authToken"){
                return ["Content-Type": "application/json", "Accept": "application/json", "Authorization": token]
            }
            return ["Content-Type": "application/json", "Accept": "application/json"]
        }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

